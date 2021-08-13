Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5043EB143
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Aug 2021 09:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbhHMHSY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Aug 2021 03:18:24 -0400
Received: from mail-vi1eur05on2130.outbound.protection.outlook.com ([40.107.21.130]:44769
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239248AbhHMHSX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Aug 2021 03:18:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDkYBpo+bYuKbS4CP9UjYisHkJ/S+fyVgssNTtDttgxuFC15xaZKSN+TsbQiVTv5to+oAVB2ubPxIRGNsl7p2wJcgr6pdwraWNtpNYPXBeoh/0mn+AHtrlSwcTSmmb0DAKKir0dN3Mp3CkPtYRi7ITKFGoppCltMjhC+qmwaWUr5mCr06g16Jc0lIQ9M1YndlXIv9ES0BOTbjfBBtFUf/QQRwQR3+JNArJ8GyBU/v4W6vnXJYOR9LQ1+lMAeHOnKKwL4dejiJb1oHI8Bibs3zuBixtTKfaVlC4lc42XRO/1EEvOENPoWTnd9yQYVDrliFBeIhX5cVLYekfh+iUzgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81wluLI4zEsaDYr98g4QWHjoyTsaJza3Jn0JHfvPLmM=;
 b=WFLKcGwtPGD6hd/efNIPXRbLFdoT7PdDBEf3QE6o2Qzmn58qN52mGSaBVaIuSrOJKp3Xu8b7+/48Ia2PEQWoREDmmv8q0Ar55/syMslwg+FjrSIe23U8PsXp2GFZKDvlgivxA/NeSS4wQiz3sdKg73/GocOH6s/N8aIsKVZ1MdjFvuZF0o2CkNpuPkPVBg5agZyvScs3FC1pouy3sBPRebxmVtDjWh53AGqDfnp0VCBdoYfgQkKC59nRVtaWg+aQQNRRd1Zhiodkdrzh17VR9uX51MIe4UvWAHuqxAqD4vwU2JkO1JIR+yRbclF+rrddHFp3ul6T/LGAkpg0FT9xAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81wluLI4zEsaDYr98g4QWHjoyTsaJza3Jn0JHfvPLmM=;
 b=EzHpa6oKcp+lTp1oXnJ8fUua4M6VTZusdpUaodFt8V/JBTsnk8nFVC0EW13QFFkIGK/DaHx17MKjVDzAszBVbPxIv4I6+eWbhqXbRZvy2fVJqmb93OXujpIOr2yhGbiXnWfqF1nbuR/YW/8MnmI0yAiiNpNeVPBiRerFg+7TkuI=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM4PR0902MB1810.eurprd09.prod.outlook.com
 (2603:10a6:200:90::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Fri, 13 Aug
 2021 07:17:55 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4415.017; Fri, 13 Aug 2021
 07:17:55 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: Re: [PATCH v7 4/5] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
Thread-Topic: [PATCH v7 4/5] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
Thread-Index: AQHXjqW6HKtkRWvTZ0yNvT6BOPuNR6tufhgAgAEGgICAAFadgIAAWBiAgADWE4A=
Date:   Fri, 13 Aug 2021 07:17:55 +0000
Message-ID: <b7cd3e6d-a23d-177b-5a6b-fb81d9bca4aa@viveris.fr>
References: <20210811114037.201887-1-simon.thoby@viveris.fr>
 <20210811114037.201887-5-simon.thoby@viveris.fr>
 <84b3a572eb5fc1ec81291656c9f9af00568bff9f.camel@linux.ibm.com>
 <023a0ec1-aed7-9862-e0c9-a825d46ade0f@viveris.fr>
 <c705ef557f40289d58ab7cbab8c2c0e7b888671e.camel@linux.ibm.com>
 <aef8a1e8cee322409ef3dc6723c7e77bc16f6b2f.camel@linux.ibm.com>
In-Reply-To: <aef8a1e8cee322409ef3dc6723c7e77bc16f6b2f.camel@linux.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab6a1a96-0029-4e63-df90-08d95e2a78bb
x-ms-traffictypediagnostic: AM4PR0902MB1810:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR0902MB1810C807E6C54D1CA8FCBDB894FA9@AM4PR0902MB1810.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 99GcDlgkqzrKLY+UcVPmRHOQRkZ9Qg3xK4OijXFEV1yRorIuvl+a65pe7A3MFF+eZFog+CuMbQ7Sh0PxMdXsWH7vLLhrnYq+9CNr7JvIbJl93G41qV8AXI5KuzFmcd4XS9zILezOsdDvESuicrj7JxRQCSndRe5ClFRgd7f7+QTZdR/aDnn01EYQ9//Dg/a4UMBopdIeDIeT685CESsdOEr45J54TJf8N7WrjEwYgTNCJA9PJ7VKRqw46gri8OgceIM38/fKbnTXjPRSBGNqQ1ODZ1zDGIi+QKfc3yb9dqkL7SDWZFvzjRcGKuQFeYXF0OB5j4UGprd5In/xmTZUv/FWxA0vETSHY9nxMa0h9y+gputbgmLXxcNZF6vnc2O0yasC2o5/fFRBm3LU94Y1E3rwGEV7o/XSZ1rtg3mce3Vqx8s/QoX4ZA5VxpL+ys3YH5gxD1J3448ML/dLyssizcfFfP6V6WyC27vPbEuXvWxYU9eeZ4p4A6/huUFLQOTv68PlD57VC2E+e/xOvOIY59v0dEZr+B0B2+yrxncL2Y1ITv/+i+vqr7002FrD/bpp0RynrRwY0RtHx76D9tet5WQxjWRPOQEFaQQyiv36+nGTBPmLVJFYwRCLa5GwccIkKGTnLQ2Lk3BuMP4oRZx2bsxKGXyyLNDuTT9xuN0ZdCcoSg6l26CnuKXLsd+8/YtYXDcpNgSpaIL/kJFV/tjepeQQbUZgQcJ+3383epqdhSAltdhICzphruqHJd6EovTp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39830400003)(346002)(376002)(122000001)(66556008)(53546011)(36756003)(6506007)(66446008)(4326008)(2616005)(38100700002)(66476007)(2906002)(6512007)(6636002)(86362001)(26005)(45080400002)(76116006)(8676002)(186003)(66946007)(71200400001)(6486002)(64756008)(8936002)(110136005)(31686004)(83380400001)(91956017)(316002)(31696002)(478600001)(38070700005)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-15?Q?ByXvVYUrncyE0Yw1MVoZ4w/5/37SSHyF3TlBINtb/2YSQY+wNmWtoBxMT?=
 =?iso-8859-15?Q?O94XblcJmo7DHX5v4vkBTt725StYKO3FHwyymIbvyf/TvPo/Tj67gAP6O?=
 =?iso-8859-15?Q?LveLyAeQMMmBD+R5WTe0J13osxnK56U1Dq2VDsDXQqXyigH192MhhrULM?=
 =?iso-8859-15?Q?b9phCOb7OXZ8cwPSX+M3DeBeifJM+wbqhUTw90ws2C4nD5hCHiziW6mhT?=
 =?iso-8859-15?Q?2bic/UmsbYIMIRFEDBFWTWlh9xEho74gJufBcTikYxscF7hfBgrPOEO+0?=
 =?iso-8859-15?Q?DDdmHyH5uK5AwPgav7g7sLZA2yN1h9eyHWa0ZA3bTGX6bj48fbZzTo5rF?=
 =?iso-8859-15?Q?C8HAUnuMRV87AaFiKSyILnS+qQKbD98eNmjKJ2cUUStU2tp0jzl7ZMu6y?=
 =?iso-8859-15?Q?CwhhgE3uyv81tbsIoLtrsl70D/txOMYXY7Gy9J7sVHTJOQ7L3pp3HacVX?=
 =?iso-8859-15?Q?9fQ9SBCdFEUrw6t5Heh2H7Hu6ZYVcXp9w0z5U7182q1la0Rlik7+WCXhs?=
 =?iso-8859-15?Q?H3L8Y+hIgn/iUpzVHNhU7aG9gFr8faIUGu2rcXwrLfIed7D6flgvooKSi?=
 =?iso-8859-15?Q?XWhkxjZ5O8jS/bVyqcMQudl/LeengNUKySxqkdtjUIicTeuJOkaKrQC7h?=
 =?iso-8859-15?Q?N57roR90omr5PrXcC7q7wWn0sCgboYfYM6XBXWGvShF+GLIUmneH3qbui?=
 =?iso-8859-15?Q?J3xGnB7f0C5OQ990orm0jId0zgFhhxSKR39etN15IUwRFeXlhEQYvOoxI?=
 =?iso-8859-15?Q?1/1nx99sXOvaE10bjPZIuYPs/qirplUmHaSgmUXqNg1IRN9IMw9dx8jXQ?=
 =?iso-8859-15?Q?INMXbbn8/npej/y/kluxatHSPECQCRIqmVure+ojFPOvnY76cz9Vkkuy/?=
 =?iso-8859-15?Q?EDnzHQkeMIw95cZdaRmZWsST1koaM8/DD8lqun5TBfR2/cUbL1LSXnno9?=
 =?iso-8859-15?Q?LXykmbENd7+wBe+PD4f0ZGM+rg8i1V17RermFhZZyqWB1Z7uA5lx1GnK/?=
 =?iso-8859-15?Q?dg92bC3CuatEmyQz6HHEjBMdIXykyLreEBkzwfpSzicAtWW83T7hKKxMm?=
 =?iso-8859-15?Q?TMbREvppS7V/pCjkzUhqLHM+CfE37bYb5Q7B0jXqgIHvQqDSTC6aPPSuD?=
 =?iso-8859-15?Q?p4i2//jxwNQBdsQfgTtHRF9htYUv9HQ3chdzVVoYHitbTDWv0mwsGvm8M?=
 =?iso-8859-15?Q?7EKPJIOPDzOU0FXKWvNfpE9AO/k30AUnAz3FQNTkYJcehz0rBjt08aRQU?=
 =?iso-8859-15?Q?RwRycsMfZtmW7AH3MhwfiLOzOnpN4DhAmzY3xrLQToo2bdT/Jf6ODFdZx?=
 =?iso-8859-15?Q?1Pyuv0aLT2EDptTk8iiexjujIZtPmr/68GENjnr4gNk74PD18xFj6TJ2g?=
 =?iso-8859-15?Q?2LBFtEQ2mfvNoKPPmaf9/1ndTyvtApq+v?=
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <2CA8B1BFFB504046A977661F1B4C2F33@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6a1a96-0029-4e63-df90-08d95e2a78bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 07:17:55.6361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LkydSfCtY7i/15K+soxQCEEvom9dIZc672f6h2GnOL3kPJ+d/xFwM5mwFDRio7E7hSOX8XtDXOx/+ZjVtU9FAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0902MB1810
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

On 8/12/21 8:31 PM, Mimi Zohar wrote:
> Hi Simon,
>=20
> On Thu, 2021-08-12 at 09:16 -0400, Mimi Zohar wrote:
>> On Thu, 2021-08-12 at 08:06 +0000, THOBY Simon wrote:
>=20
>>> However your comment does applies to the next patch ("IMA: introduce a =
new policy
>>> option func=3DSETXATTR_CHECK"), and we probably could restrict the algo=
rithms referenced in
>>> ima_setxattr_allowed_hash_algorithms to ones the current kernel can use=
.=20
>>> The easiest way to enforce this would probably be to check that when pa=
rsing 'appraise_algos'
>>> in ima_parse_appraise_algos(), we only add algorithms that are availabl=
e, ignoring - or
>>> rejecting, according to the outcome of the discussion above - the other=
 algorithms. That way,
>>> we do not have to pay the price of allocating a hash object every time =
validate_hash_algo() is
>>> called.
>>>
>>> Would it be ok if I did that?
>>
>> Without knowing and understanding all the environments in which IMA is
>> enabled (e.g. front end, back end build system), you're correct -
>> protecting the user from themselves -might not be the right answer.
>>
>> What you suggested, above, would be the correct solution.  Perhaps post
>> that change as a separate patch, on top of this patch set, for
>> additional discussion.
>=20
> Before posting the patch, please fix your user name and email address
> in the git configuration.  scripts/checkpatch.pl is complaining:
>=20
> ERROR: Missing Signed-off-by: line by nominal patch author 'THOBY Simon
> <Simon.THOBY@viveris.fr>'

>=20
> total: 1 errors, 0 warnings, 218 lines checked

I guess Microsoft Exchange strikes again :/
On my end, the patches have the correct 'From: Simon Thoby <simon.thoby@viv=
eris.fr>'
header, but it seems Outlook likes to rewrite headers to match my Microsoft=
 work account
information. I will update my git config, as I can't edit the name and emai=
l of the corporate
account.
Sorry about that.


>=20
> thanks,
>=20
> Mimi
>=20

Thanks,
Simon=
