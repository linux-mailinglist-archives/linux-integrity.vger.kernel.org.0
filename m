Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633EF622DF9
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Nov 2022 15:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiKIOcY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Nov 2022 09:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiKIOcV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Nov 2022 09:32:21 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EB110D2;
        Wed,  9 Nov 2022 06:32:20 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9ETdYR004307;
        Wed, 9 Nov 2022 14:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ayokGMLphMXnEwDGhQNM+ugF7/upOLMZV8v6ltKu1yk=;
 b=Bq8eRlj/LhqRd5b9jmf6KuW2Xpce5F6P91tvvNoGbecP+u6uoN0THI8YpCBiKOKwRLZC
 3WENovmts0cmLni555JNuR8CtiE2ba+lR2p0MCvfTpz8HUyIhHAheVKqmZsSzFdjNHpQ
 hQmS9KdtAbeQmkxLwM3oKzzK4SjbPdybjfpsSavFmkxyQYCr/krsATDoI0H8xU+BcDHW
 K1rki1ZwCADe0qqxac6ar1Dw0TOaYndARPoq3JISq6tWaZ1leC8dDaIzlZJ6Cn5fp+/R
 6wHuYLP6yPAhusQGuUIxnzgLg2VstyVGpkHiOYw0+6kXghZ7m0IouEdaYpE2Isl+lwHw oQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krddar578-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 14:30:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9CZ97w040275;
        Wed, 9 Nov 2022 14:25:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqhhrjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 14:25:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6lnblsJQ8sb0AP7z4hQ1ReFX+3wu8ViiG2s0SpGmfVAubgTo71KgQrZOXs2N4Z6660H+jbR7irkCHrNpQ7IVJzZFlxJTEUCJkGeG17VAzysZbHzOIGM7UjL37eFGl5BnbkstK2GPAYrho8fYoup9ttRSdNBZZ9wassW7pSvChe8AlTPeiijBl7h6WsCKKLm0522SD+BpgCZtZQ+SYgAU9THaFO9WMPIVDeBnsSzwSLzs7KgT8OB8G0tu+m+na1lqdFLRhqxuZ9YHusy4ylA5iN/c+qMdSdO+TcCmhE4aS1FVe16U8xaw+V7q7gD94gYbLMrHMiGErLHTz5I1EwaDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayokGMLphMXnEwDGhQNM+ugF7/upOLMZV8v6ltKu1yk=;
 b=ed4jdkwEf+AC2QkRYv2srC7Tccw/TTXzqc2eYErA44TUnmI+//irbVkQiLHzhI8Q9Fotej7wR1NFOW5Fl80h1cVYLtqmLyNY7IarvTLEMXhGYwX+Xo3eMF8O60oeSO6szU49z9ytSnUJ7oh7zOyCN6heFpMDbgXqUyvY/KDEw/1TCLd4hcrePRIhBFbQxqT4E1G6fErCG9rBt85zosydmMWf7lKM1tQTWYX2r9EZQCWqd++aWdU557dbCB6aZj46lLvXpxK5YSelohDRyYY7nc6GROOMxvJ4Q9lRa66ZehVAldIhr0oL7rG1w+4AKjmuLqzXC1HJnzBhv4Wde/ITlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayokGMLphMXnEwDGhQNM+ugF7/upOLMZV8v6ltKu1yk=;
 b=oHi7c2nk9rPzE4cekw+BGbCwzaxLIaLOO/TVtNdv7UaG8YOGEBSLbcMjsw+swKu1iTNfDMQtQBS3Nufm3ns0al4jqlBl+Hf0616Ux1JetJYgpz1x2T1wyQD4lpfcGFQPBMl3EFM+/5CMJtDJLOnDNncCFBVBNuAuI3H/Cu/23Uc=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by IA0PR10MB6891.namprd10.prod.outlook.com (2603:10b6:208:431::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 14:25:08 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%5]) with mapi id 15.20.5813.012; Wed, 9 Nov 2022
 14:25:08 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Elaine Palmer <erpalmerny@gmail.com>
CC:     Coiby Xu <coxu@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        David Howells <dhowells@redhat.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "jmorris@namei.org" <jmorris@namei.org>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "tiwai@suse.de" <tiwai@suse.de>, Mimi Zohar <zohar@linux.ibm.com>,
        "erpalmer@linux.ibm.com" <erpalmer@linux.ibm.com>
Subject: Re: [PATCH 0/7] Add CA enforcement keyring restrictions
Thread-Topic: [PATCH 0/7] Add CA enforcement keyring restrictions
Thread-Index: AQHYSVko0FaTAwO/wkyht4hUdft6wK4wDb+AgAcTfACAANo0gA==
Date:   Wed, 9 Nov 2022 14:25:08 +0000
Message-ID: <82E1339C-629A-48F5-99B0-179251BBC708@oracle.com>
References: <20221104132035.rmavewmeo6ceyjou@Rk>
 <faa10c58-268f-ddc8-b86c-02c903e29f8a@gmail.com>
In-Reply-To: <faa10c58-268f-ddc8-b86c-02c903e29f8a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|IA0PR10MB6891:EE_
x-ms-office365-filtering-correlation-id: c4964cbc-5d92-417a-ba3b-08dac25e3412
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6R6CeH+DqbXM91qfQdkf/QcxnntKOQR/f4iIeKqC1Z5HLTEuy5sCHwVs0X1QjXBcb9M07NaUZ9+jiurBBQDulD5cRxO2Zd+yUBfftRadOlNoUw4laKs3KOIlWI6Av5poxqpHGqQ39y8A9JuupfkXlcjTLAn5GWOnVccjQh7ymE/clR81SRZQi1AtLx9FmKE9zqe7dR5OJi/Fn+4cZlreKyUFbLUt4RyhoJHNowZnX1KYfRMne51PLVGxrS1Wux1fFXKpNl+3RBEdGHi0q6dMHDUJxohFx+coFSpYIEWoMrwjDcIlrn074qLb7wSx1Yedbupee3m+988jwzKHWn6e9CdE4Z2hq5LYtfGrLLM7BCSkCCaZCcRMX9yunqZkiAtlwHmTi9Ft2UHWTSHfHi6pte+vR+FXdszy0/Gv3H7N4Bm0czgi/bZG9ob6rFoxZg4WlNqM7OiNYr4I0QVx9qqDaVjxu9ZJPB/VFbxNoVmIfAG9QXnFWrfMFBZYJJNYERIy3T/DiXxiGMbWOVc1UYG+slzlW6CSLEk2euanYbafyMWkotIfrJ9PwEsqnwWP6xy0M2DTtWyE3qozV4X0ZY2Lvo7XUdksEUMjHx3FFdKT6QoYgs2a4LM96QJXiTEVbOlIDyiytoUQrOPr4yz50aHh83dgQwLCxQ+wPrWUz57gQQYtenTpV/+4yRdk6LGhqZUGnK638TuBShGOncCGRU1+PxH3r+1Ir1mziBdSK6uwmS5rYKgHwiCru2EwLXTNPII12A7ABJxL4G8GZLWau5ZWHrUd2mm7+yXSxijY+lh5wiE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199015)(33656002)(36756003)(83380400001)(186003)(53546011)(2616005)(6512007)(6506007)(26005)(122000001)(38070700005)(38100700002)(7416002)(2906002)(5660300002)(86362001)(54906003)(110136005)(71200400001)(316002)(478600001)(6486002)(41300700001)(8936002)(66946007)(8676002)(4326008)(91956017)(66476007)(64756008)(66446008)(76116006)(66556008)(44832011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sUAZw6HDK3Sc2aThlKQ1qcF/uVI9fhvjf3hsUCI5w1FvsKRTNRozdH6m4Spr?=
 =?us-ascii?Q?HsZugfHks9qsAlBqdFVLnCCNbPuhYW+3E12VlkLcDNJnVTfvxyFK0BRB5S3u?=
 =?us-ascii?Q?NG+ZkXrctpPu1S8MxdoEd4/gw1MCFbrF8xLLOPb7eGJ/nAJSX2Of8sGme40Q?=
 =?us-ascii?Q?l2E3iXuXDiEomc2hfs5eqUssebRV8qkfl4dg3gGyUug0LztlorW4DXu/ppR7?=
 =?us-ascii?Q?RIb/3RzrMTqYrMnioAP+tipjeWlbgMoI5s8ojmfHE2bM5UpRrWDONfgPPupy?=
 =?us-ascii?Q?2zT4nu21+xvBggDGxQEfHpEcHpNw56NMDV5UeNLxouftR2I6Vc+1vDKwVeRk?=
 =?us-ascii?Q?eciq3d+ONKPPui6jgCxrMtXlNkLlcZmrtQ/dLK4YaO6nutT0a3RuhZYw4OVk?=
 =?us-ascii?Q?e1FkScyUBXLP1Kjp5StOpXioTF9dUtrOqPRDIq+lfD8DRt58RNidjZgSe5Jb?=
 =?us-ascii?Q?joGLkdKPEt0WMWoW7QFYxBeDYWihmlAKMbaHzVmlzxT8Op7KCSoHWBFLsZeo?=
 =?us-ascii?Q?r7ZwRCcJHRSNGJQ5JwX77CGanzf2qQZ/0QT8FCir2AWEzGeY2p3SKlsLuNQY?=
 =?us-ascii?Q?AnoqUF0SzTWCZAJHjNXlqg1vHRX5RHVXCo+1Sz68Fs70eSA0R46RgZJMbyrm?=
 =?us-ascii?Q?QIYYfTBg5+k5PQfyIVNgGJPG1A3MLA2vxnIh0c2UadYtSntlI0WiIENT39vA?=
 =?us-ascii?Q?nepn0PQodwmpzNVPe8h5PJ4Dbj6fxH439GQ7rngdag4S0mg65qmV/7fp7HTe?=
 =?us-ascii?Q?gnb4qMxCqtRfwiMqOzF81AUtrvFDfR2JUsDXC2hqeRepIqcqyDCLDKeUEdUd?=
 =?us-ascii?Q?AGuMJN2WsVszghd7Bpfx9XDrM9CZLiZel+JpK8iKkvWtOouwiVolbPO6NaIK?=
 =?us-ascii?Q?wnB1dxtK4km0wuFbxI/SZe7NjjtE+LbxPAFlINtW3RLr0Crd4OrQtGVzZcbM?=
 =?us-ascii?Q?CsR9jgdr03xD7XEE4zsYpB0RuJddJyS3Z23T3M877wt5RGMDpgdRAhxHPWSU?=
 =?us-ascii?Q?ZVDLwhuIMpuk9KUkNYDBCgVB0y52q5npOvpOk12VZaSJIyUNT6nelJWnm5WM?=
 =?us-ascii?Q?FO3DVrCGTFu56UArVTlJTLjec2nRxTGAIJqCk4N84QIHzIsY3+kINbml2i8T?=
 =?us-ascii?Q?l1bNLEUWKiVX13j6XjUbn4W5qs2aWe/mWuBsyb175My7TxJu/4pIHjASBZmI?=
 =?us-ascii?Q?EUvCU2Ax9nzbPP+vvNOEYWage0Uj5fmP4FWWPRBILaAYyDThRW4WKsPW22n6?=
 =?us-ascii?Q?yMGl5E5PUKui8Vo1mK6FZpnXaSRZseEM0KrzlM7Qrwff8V2/e8nJYGxmGZfW?=
 =?us-ascii?Q?3UvL8BQtNjy8VmrWwSW00cSuQA3s2gbK8Clvs/Lt0xmjuKJZi88fni9xzQGp?=
 =?us-ascii?Q?CYxBvGCXcCQFTWSY5tHFRTiGNyaa79wC44aCW7L7XSWNKJyJ48YeUXvxa73i?=
 =?us-ascii?Q?lzZqEmhpCKebzvvtUQg4ReMbgyV+MYJrrfWfRPpFqPSxoqzSGVSITSnHe7wU?=
 =?us-ascii?Q?5ieflFLw3YOlE8m/zqM8A2ePYgmmnuuUdjdzJCGvOQZSqZ9j7bpBC7caOtQX?=
 =?us-ascii?Q?vat3QT/v6A34Dwz1BPcgY3ov6ZbOn4XVy8IFs7wue4a6Ibe0VZk3VFJY//CJ?=
 =?us-ascii?Q?xA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <673C1B12C9174D41B38B284AEC400DFC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4964cbc-5d92-417a-ba3b-08dac25e3412
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 14:25:08.1922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w0c1XlqLYj3vnWprxBIkFuKH1lpXzOHTgXSeq6UyYvml3KxtqaEsdsOIEc7dEu1/S7FZtPFMoqmP2btRWenOiulMeneUqehpQc7mCrqMVys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6891
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090109
X-Proofpoint-GUID: 9NcdyLlx8fyxS9OG2QM5Zie64_0qqpk7
X-Proofpoint-ORIG-GUID: 9NcdyLlx8fyxS9OG2QM5Zie64_0qqpk7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> On Nov 8, 2022, at 6:24 PM, Elaine Palmer <erpalmerny@gmail.com> wrote:
>=20
>=20
>=20
> On 2022/11/04 9:20 AM, Coiby Xu wrote:
>> Hi Eric,
>>=20
>> I wonder if there is any update on this work? I would be glad to do
>> anything that may be helpful including testing a new version of code.
>>=20
> Hi Coiby,
>=20
> Yes, this discussion got stuck when we couldn't agree on one of the
> following options:
>=20
> (A) Filter which keys from MOK (or a management system) are loaded
>     onto the .machine keyring. Specifically, load only keys with
>     CA+keyCertSign attributes.
>=20
> (B) Load all keys from MOK (or a management system) onto the
>     .machine keyring. Then, subsequently filter those to restrict
>     which ones can be loaded onto the .ima keyring specifically.
>=20
> The objection to (A) was that distros would have to go through
> two steps instead of one to load keys. The one-step method of
> loading keys was supported by an out-of-tree patch and then by
> the addition of the .machine keyring.
>=20
> The objection to (B) was that, because the .machine keyring is now
> linked to the .secondary keyring, it expands the scope of what the
> kernel has trusted in the past. The effect is that keys in MOK
> have the same broad scope as keys previously restricted to
> .builtin and .secondary. It doesn't affect just IMA, but the rest
> of the kernel as well.
>=20
> I would suggest that we can get unstuck by considering:
>=20
> (C) Defining a systemd (or dracut module) to load keys onto the
>     .secondary keyring
>=20
> (D) Using a configuration option to specify what types of
>     .machine keys should be allowed to pass through to the
>     .secondary keyring.
>   =20
>     The distro could choose (A) by allowing only
>     CA+keyCertSign keys.
>=20
>     The distro could choose (B) by allowing any kind
>     of key.
>=20
> We all seemed to agree that enforcing key usage should be
> implemented and that a useful future effort is to add policies
> to keys and keyrings, like, "This key can only be used for
> verifying kernel modules."
>=20
> I hope we can come to an agreement so work can proceed and IMA
> can be re-enabled.

I would be open to making the changes necessary to support both (A and B)=20
options.  What type of configuration option would be considered?  Would thi=
s=20
be a compile time Kconfig, a Linux boot command line parameter, or another=
=20
MOK variable?

