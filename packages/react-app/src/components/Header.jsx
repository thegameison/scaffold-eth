import React from "react";
import { PageHeader } from "antd";

export default function Header({ swapDist, swapTran, swapGa }) {
  return (
    <div id="top" target="_blank" rel="noopener noreferrer">
      <div class="logo">
        <div class="bottom">AllenCoin</div>
      </div>
      <div id="menu">
        <div class="icon-button" onClick={swapDist} >Claim</div>
        <div class="icon-button" onClick={swapTran}  >Transfer</div>
        <div class="icon-button" onClick={swapGa} >Giveaways</div>
      </div>
    </div>
  );
}
