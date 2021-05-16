import React, { useCallback, useEffect, useState } from "react";
import "antd/dist/antd.css";
import { InfuraProvider, JsonRpcProvider, Web3Provider } from "@ethersproject/providers";
import "./App.css";
import { Row, Col } from "antd";
import Web3Modal from "web3modal";
import WalletConnectProvider from "@walletconnect/web3-provider";
import { useUserAddress, useBalance } from "eth-hooks";
import { useExchangePrice, useGasPrice, useUserProvider } from "./hooks";
import { Header, Account, Faucet, Ramp, Contract } from "./components";
import Hints from "./Hints";
import { INFURA_ID } from "./constants";

const web3Modal = new Web3Modal({
  // network: "mainnet", // optional
  cacheProvider: true, // optional
  providerOptions: {
    walletconnect: {
      package: WalletConnectProvider, // required
      options: {
        infuraId: INFURA_ID,
      },
    },
  },
});

// 🛰 providers
const mainnetProvider = new InfuraProvider("mainnet", INFURA_ID);
const localChainProvider = new JsonRpcProvider(
  process.env.REACT_APP_PROVIDER ? process.env.REACT_APP_PROVIDER : "http://localhost:8545",
);

const logoutOfWeb3Modal = async () => {
  await web3Modal.clearCachedProvider();
  // console.log("Cleared cache provider!?!",clear)
  setTimeout(() => {
    window.location.reload();
  }, 1);
};

function App() {
  const [dist, setDist] = useState(false);
  const swapDist = () => {
    setDist(true);
    setTran(false);
    setGa(false);
    setHome(false);
  }
  const [tran, setTran] = useState(false);
  const swapTran = () => {
    setTran(true);
    setDist(false);
    setGa(false);
    setHome(false);
  }
  const [ga, setGa] = useState(false);
  const swapGa = () => {
    setGa(true);
    setDist(false);
    setTran(false);
    setHome(false);
  }
  const [home, setHome] = useState(true);
  const swapHome = () => {
    setHome(true);
    setGa(false);
    setDist(false);
    setTran(false);
  }



  const [injectedProvider, setInjectedProvider] = useState();
  const price = useExchangePrice(mainnetProvider);
  // const gasPrice = useGasPrice("fast");

  // Use your injected provider from 🦊 Metamask or if you don't have it then instantly generate a 🔥 burner wallet.
  const userProvider = useUserProvider(injectedProvider, localChainProvider);
  const address = useUserAddress(userProvider);

  // 🏗 scaffold-eth is full of handy hooks like this one to get your balance:
  const yourLocalBalance = useBalance(localChainProvider, address);
  // just plug in different 🛰 providers to get your balance on different chains:
  // const yourMainnetBalance = useBalance(mainnetProvider, address);

  // Load in your local 📝 contract and read a value from it:
  // const readContracts = useContractLoader(localProvider)
  // console.log("readContracts",readContracts)
  // const owner = useCustomContractReader(readContracts?readContracts['YourContract']:"", "owner")

  const loadWeb3Modal = useCallback(async () => {
    const provider = await web3Modal.connect();
    setInjectedProvider(new Web3Provider(provider));
  }, [setInjectedProvider]);

  useEffect(() => {
    if (web3Modal.cachedProvider) {
      loadWeb3Modal();
    }
  }, [loadWeb3Modal]);

  return (
    <div className="App">
      <Header swapDist={swapDist} swapTran={swapTran} swapGa={swapGa} swapHome={swapHome}/>

      <div style={{ position: "fixed", textAlign: "right", float: "right", right: 0, bottom: 20, padding: 10 }}>
        <Account
          address={address}
          localProvider={localChainProvider}
          userProvider={userProvider}
          mainnetProvider={mainnetProvider}
          price={price}
          web3Modal={web3Modal}
          loadWeb3Modal={loadWeb3Modal}
          logoutOfWeb3Modal={logoutOfWeb3Modal}
        />
      </div>

      {/*
          🎛 this scaffolding is full of commonly used components
          this <Contract/> component will automatically parse your ABI
          and give you a form to interact with it locally
      */}

      {/* this name prop is very important! It basically indicates to the Contract component
      which one of our smart contracts to use. */}

      {/* <Contract name="YourToken" provider={userProvider} address={address} /> */}
      {home && <div id="middle">Welcome to AllenCoin. AllenCoin is an ERC20 token that lets you reward others for community involvement or good deeds. In the "Claim" tab,
        claim one AllenCoin once a week. In the "Transfer" tab, view your balance and send coins to other users. In the "Giveaways" tab, join a Giveaway, or if you're
        an Admin, run a giveaway.
      </div>}
      {dist && <Contract fns={["claim"]} name="Distributor" provider={userProvider} address={address} />}
      {tran && <Contract fns={["transfer", "balanceOf"]} name="YourToken" provider={userProvider} address={address} />}
      {ga && <Contract fns={["getGiveaway", "doGiveaway", "whiteListAdd", "entries", "prevWinner"]}name="Giveaway" provider={userProvider} address={address} />}

      {/* <Hints address={address} yourLocalBalance={yourLocalBalance} price={price} mainnetProvider={mainnetProvider} /> */}

      <div style={{ position: "fixed", textAlign: "left", float: "left", left: 0, bottom: 20, padding: 10 }}>
        <Row align="middle" gutter={4}>
          <Col span={9}>
            <Ramp price={price} address={address} />
          </Col>
          <Col span={15}>
            <Faucet localProvider={localChainProvider} price={price} />
          </Col>
        </Row>
      </div>
    </div>
  );
}

export default App;
