Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57238175791
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Mar 2020 10:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgCBJq0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Mar 2020 04:46:26 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2485 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727498AbgCBJq0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Mar 2020 04:46:26 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id B2AAD9DF79AC803B8C56;
        Mon,  2 Mar 2020 09:46:24 +0000 (GMT)
Received: from fraeml704-chm.china.huawei.com (10.206.15.53) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 2 Mar 2020 09:46:24 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 2 Mar 2020 10:46:23 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Mon, 2 Mar 2020 10:46:23 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     kernel test robot <rong.a.chen@intel.com>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        "lkp@lists.01.org" <lkp@lists.01.org>
Subject: RE: [ima] 9165b814d2: BUG:kernel_NULL_pointer_dereference,address
Thread-Topic: [ima] 9165b814d2: BUG:kernel_NULL_pointer_dereference,address
Thread-Index: AQHV8DEWZqyGfs8H/kW8+ywKreXaD6g1CQuA
Date:   Mon, 2 Mar 2020 09:46:23 +0000
Message-ID: <0b454d6825824d3d9e4a99b552cc5f84@huawei.com>
References: <20200205103317.29356-9-roberto.sassu@huawei.com>
 <20200302012218.GU6548@shao2-debian>
In-Reply-To: <20200302012218.GU6548@shao2-debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.220.96.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBrZXJuZWwgdGVzdCByb2JvdCBb
bWFpbHRvOnJvbmcuYS5jaGVuQGludGVsLmNvbV0NCj4gU2VudDogTW9uZGF5LCBNYXJjaCAyLCAy
MDIwIDI6MjIgQU0NCj4gVG86IFJvYmVydG8gU2Fzc3UgPHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNv
bT4NCj4gQ2M6IHpvaGFyQGxpbnV4LmlibS5jb207IEphbWVzLkJvdHRvbWxleUBIYW5zZW5QYXJ0
bmVyc2hpcC5jb207DQo+IGphcmtrby5zYWtraW5lbkBsaW51eC5pbnRlbC5jb207IGxpbnV4LWlu
dGVncml0eUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBzZWN1cml0eS1tb2R1bGVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBTaWx2aXUNCj4gVmxhc2Nl
YW51IDxTaWx2aXUuVmxhc2NlYW51QGh1YXdlaS5jb20+OyBSb2JlcnRvIFNhc3N1DQo+IDxyb2Jl
cnRvLnNhc3N1QGh1YXdlaS5jb20+OyBsa3BAbGlzdHMuMDEub3JnDQo+IFN1YmplY3Q6IFtpbWFd
IDkxNjViODE0ZDI6DQo+IEJVRzprZXJuZWxfTlVMTF9wb2ludGVyX2RlcmVmZXJlbmNlLGFkZHJl
c3MNCj4gDQo+IEZZSSwgd2Ugbm90aWNlZCB0aGUgZm9sbG93aW5nIGNvbW1pdCAoYnVpbHQgd2l0
aCBnY2MtNyk6DQo+IA0KPiBjb21taXQ6IDkxNjViODE0ZDJiZWE4Y2ZlYjU1NzUwNWJiMjA2Mzk2
MzMxZTgxOTIgKCJbUEFUQ0ggdjIgOC84XQ0KPiBpbWE6IFVzZSBpbWFfaGFzaF9hbGdvIGZvciBj
b2xsaXNpb24gZGV0ZWN0aW9uIGluIHRoZSBtZWFzdXJlbWVudCBsaXN0IikNCj4gdXJsOiBodHRw
czovL2dpdGh1Yi5jb20vMGRheS1jaS9saW51eC9jb21taXRzL1JvYmVydG8tU2Fzc3UvaW1hLXN1
cHBvcnQtDQo+IHN0cm9uZ2VyLWFsZ29yaXRobXMtZm9yLWF0dGVzdGF0aW9uLzIwMjAwMjA1LTIz
MzkwMQ0KPiBiYXNlOiBodHRwczovL2dpdC5rZXJuZWwub3JnL2NnaXQvbGludXgva2VybmVsL2dp
dC96b2hhci9saW51eC1pbnRlZ3JpdHkuZ2l0DQo+IG5leHQtaW50ZWdyaXR5DQoNCkhpDQoNCnRo
YW5rcyBmb3IgdGhlIHJlcG9ydC4NCg0KWWVzLCB2ZXJzaW9uIDIgaGFkIGEgYnVnOg0KDQotLS0N
CgkJaW1hX2FsZ29fYXJyYXlbaSsrXS5hbGdvID0gSEFTSF9BTEdPX1NIQTE7DQoJfQ0KDQoJaWYg
KGltYV9oYXNoX2FsZ29faWR4ID49IG5yX2FsbG9jYXRlZF9iYW5rcykgew0KCQlpbWFfYWxnb19h
cnJheVtpXS50Zm0gPSBpbWFfc2hhc2hfdGZtOw0KCQlpbWFfYWxnb19hcnJheVtpXS5hbGdvID0g
aW1hX2hhc2hfYWxnbzsNCgl9DQotLS0NCg0KVGhlIGNvZGUgYWxsb2NhdGVkIGltYV9hbGdvX2Fy
cmF5IHdpdGggc2l6ZSAxIChUUE0gd2FzIG5vdCBmb3VuZCBhbmQNCnRoZSBkZWZhdWx0IGFsZ29y
aXRobSBpcyBTSEExKS4NCg0KSG93ZXZlciwgbGF0ZXIgaXQgaW5pdGlhbGl6ZXMgaW1hX2FsZ29f
YXJyYXkgZm9yIFNIQTEgYW5kIGluY3JlbWVudHMgdGhlDQppIHZhcmlhYmxlLiBTaW5jZSB0aGUg
Y29kZSBkb2VzIG5vdCBjaGVjayBpZiB0aGUgZGVmYXVsdCBhbGdvcml0aG0gaXMgU0hBMSwNCnRo
ZSBsYXN0IHBhcnQgaXMgYWxzbyBleGVjdXRlZCBhbmQgY2F1c2VzIGNvcnJ1cHRpb24sIGJlY2F1
c2UgaW1hX2FsZ29fYXJyYXkNCmhhcyBvbmx5IG9uZSBlbGVtZW50Lg0KDQpJIGZpeGVkIGFscmVh
ZHkgdGhpcyBidWcgaW4gdmVyc2lvbiAzIG9mIHRoZSBwYXRjaCBzZXQuDQoNClRoYW5rcw0KDQpS
b2JlcnRvDQoNCkhVQVdFSSBURUNITk9MT0dJRVMgRHVlc3NlbGRvcmYgR21iSCwgSFJCIDU2MDYz
DQpNYW5hZ2luZyBEaXJlY3RvcjogTGkgUGVuZywgTGkgSmlhbiwgU2hpIFlhbmxpDQo=
