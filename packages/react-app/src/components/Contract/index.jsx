import React, { useMemo } from "react";
import { Card } from "antd";
import { useContractLoader, useContractExistsAtAddress } from "../../hooks";
import Account from "../Account";
import DisplayVariable from "./DisplayVariable";
import FunctionForm from "./FunctionForm";

const noContractDisplay = (
  <div>
    Loading...{" "}
    <div style={{ padding: 32 }}>
      You need to run{" "}
      <span style={{ marginLeft: 4, backgroundColor: "#f1f1f1", padding: 4, borderRadius: 4, fontWeight: "bolder" }}>
        yarn run chain
      </span>{" "}
      and{" "}
      <span style={{ marginLeft: 4, backgroundColor: "#f1f1f1", padding: 4, borderRadius: 4, fontWeight: "bolder" }}>
        yarn run deploy
      </span>{" "}
      to see your contract here.
    </div>
  </div>
);

export default function Contract({ account, gasPrice, provider, name, show, price, fns }) {
  const contracts = useContractLoader(provider); // gets all contracts from the target chain
  const contract = contracts ? contracts[name] : ""; // indicates which contract to fetch
  const address = contract ? contract.address : ""; // some address on the chain?
  const contractIsDeployed = useContractExistsAtAddress(provider, address);

  const contractDisplay = useMemo(() => {
    if (contract) {
      return Object.values(contract.interface.functions).map(fn => {
        if (show && show.indexOf(fn.name) < 0) {
          // do nothing
        } else if (fn.type === "function" && fn.inputs.length === 0 && fns.indexOf(fn.name) >= 0) {
          // If there are no inputs, just display return value
          return <DisplayVariable key={fn.name} contractFunction={contract[fn.name]} functionInfo={fn} />;
        } else if (fn.type === "function" && fns.indexOf(fn.name) >= 0) {
          // If there are inputs, display a form to allow users to provide these
          console.log("FUNCTION NAME:" + fn.name)
          return (
            <FunctionForm
              key={fn.name} // function name
              contractFunction={contract[fn.name]} // is this where we define how to transfer our own tokens?
              functionInfo={fn} 
              provider={provider}
              gasPrice={gasPrice}
            />
          );
        } else {
          console.log("UNKNOWN FUNCTION", fn);
        }
        return <div key={fn.name} />;
      });
    }
    return <div />;
  }, [contract, gasPrice, provider, show]);

  return (
    <div style={{ margin: "auto", width: "70vw" }}>
      <Card>
        {contractIsDeployed ? contractDisplay : noContractDisplay}
      </Card>
    </div>
  );
}
