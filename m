Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1ED6485C2
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Dec 2022 16:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiLIPo4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Dec 2022 10:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLIPoy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Dec 2022 10:44:54 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9579027938;
        Fri,  9 Dec 2022 07:44:53 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9EwuYl012891;
        Fri, 9 Dec 2022 15:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=JHkwOogfG2FY2JaA3Vbnp7WcKjjAH/3tJMmW92wcUtU=;
 b=Mp9b7/bcmFMbyitI4ha/x4fJFkJLOyLSvZy8oCcg0ubET9sc6SiCcsHAxnI5RyqaYNM5
 tRanOjNVgrq/hJw8iMalhyCNKq7QWcODSdJIuqLbofxvsKdDiBTBPv9Y0B/hEec2h/Dw
 VeMpW7N5zk0K5cSWFtaGPCXrPkO0UtvitGTanVnVqtACZYLcEP1L9YZGiyFLqCtzkjCv
 4LKc4yf9pkhG7n7UDmx/anf2I6hUKL60n2Jrb5kliApAIPzdrMN4Z+VUzKyVc+ifUhsW
 IqcoJbULY2X+1pxfHf38CQTBHplVT32+IV0xBGfB+OWxpWdWuNBPuibgKBOeLYE0C4IQ Cw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mauduwawj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 15:44:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B9EASQH006731;
        Fri, 9 Dec 2022 15:44:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa81gvrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 15:44:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIiHSkOjBn8ezYUvJAgWJhEeOTFpjGLM/D7VITvaLZ8zVWRkesDLCWI8kkOMAfqnlk2LG+sE/k4J13csrPDWQ4fckoHT8HpFxom46vZV0Tn7vTAs0HD2IKO8lBJ8/g9C3Yq73EPFoN2PZCoh1sDYbHznU5JSzTjcVLBPl6yMFGQGkPZ74pb1l6eiBbPcNp4SuRhD3FadCZk8K6mvBe0uykn0IdYEtzK5dE9tyCnu1zXpAfAw/63OAoavfJTc8473k3c3vm8Uaz94PyDSALiv2JEDC/kUNR2+lzTbiBjVdQdt++QjbHTOgPkA92LY8jkyHK/9OGTZiKRvZTFXMwWwHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHkwOogfG2FY2JaA3Vbnp7WcKjjAH/3tJMmW92wcUtU=;
 b=XB64+6vT+h4RCPA6ZBkfs611jEUxUF3p14j2Cn/8b3D95u+hjrKPyuN5rEvntXUoixVVn0rgV32E1nxbJ23gBTe7LoMCc5pkIsIfHrdZpp5jgbjWZtR0p8KbuykDS/eBUnqnS6Q9KPe8cS73mH/ct9WKc+jtWOxKOtOaAlk4A9ntiP3nhNoI0pM6lqsG570sBRmxKCfbHp77eCFmULDghQG1El7V53XjZeSytJ71C2cs8v78j+Yu2w8Sj3vaPY7mLxNswBm1J1Hb3MBiNwACl7gGT1vra2p6m9jDQEL6d+4uj9Jma8Mnm01T2jh6b/X3HqftEYUXkzO1293zEDvY6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHkwOogfG2FY2JaA3Vbnp7WcKjjAH/3tJMmW92wcUtU=;
 b=DXnAJ1SNQ4donS8Cb8he/Q6rkB6KosoHAv90dAEE+uxIZhhtI7ceTS+pmtxJT1i34IMeIt/UyJVHOZzqfKO9wARwJQ8Lw2b9EkZ8D1HDkqIhR25+U0PRrA73xLA3u6JYkJgd09z1R3qFtCdyeyNHBnJYmdcFBhn9g0F/q/Txr2M=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by PH0PR10MB5896.namprd10.prod.outlook.com (2603:10b6:510:146::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18; Fri, 9 Dec
 2022 15:44:17 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 15:44:17 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, Coiby Xu <coxu@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>,
        "noodles@fb.com" <noodles@fb.com>, "tiwai@suse.de" <tiwai@suse.de>,
        "bp@suse.de" <bp@suse.de>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Elaine Palmer <erpalmer@linux.vnet.ibm.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 00/10] Add CA enforcement keyring restrictions
Thread-Topic: [PATCH v2 00/10] Add CA enforcement keyring restrictions
Thread-Index: AQHZCl8bkpg6/vUjKkKDWz2KOwAYDq5lXJMAgABY3gA=
Date:   Fri, 9 Dec 2022 15:44:17 +0000
Message-ID: <5AF81A9E-C4E7-4BEB-86E1-4D2DB613FBF1@oracle.com>
References: <20221207171238.2945307-1-eric.snowberg@oracle.com>
 <20221209102612.wa3oftpqupzplx6h@Rk>
In-Reply-To: <20221209102612.wa3oftpqupzplx6h@Rk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|PH0PR10MB5896:EE_
x-ms-office365-filtering-correlation-id: c3b3d20e-3fb1-4315-16e0-08dad9fc3b1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8TS2NEwWQoNr67nca7U+53QJHAbqd4GOUz4NnT2TnPip/WEGjFRIGsiVnt93kbx21+mHmokMWNeFqLEDLoHUccp4ww1nLxmUw+fln/6BxwMWceI6T6G7FZSmjyFQekrcKhW6RyEhGQ804YimppYuwQNp0Ye0ltgrJq7LJEoS0pH/rE5b+6KbYCGelrCqtVg2aVO2Z93ieuZ8V4NrxxB10qCi4xGEqi58K4fQwkv5SSKzyZ2/SmbvrU5xhk5vtDP/2q2frFpK1fXQqnHOLm1vpwPWx5lJcdeaQ4uMmC6nHAodNFsjwW30Z5aGhlA6i+MicyGopxG/luHtoViB6dPs186Xx2DCnEFdkBCM4c2udsJhbeOKWnzBckxw2zU+nIA/0bAb5AMOQ/NhrJtQibN+W12PAjqeSJkM79A/j3easxZP8AyYtlgpzPnuJnlvQIVQ6eVk8/JVCG0k0mrhoZdE20AMmJp+VXZRKuiitI49pN0PSFAMPVojEPWumYXIH4FC4qZ432UCABWQhNmZPjMZJ3grRRt4NnKUhqF/FqylQMpyw48jA0DCmkkBIJapVzkCn6tiZY2/In7YvhMVL7o+34O0Y+T6fvRV8JBZJnRqKKou1PICYoljYvWQw397nTBovfhRCCH23roRR/aBNHp0isn10DwSgt81eheAu8I9wrDfLCyCWAjAgyqDuzy65/ADGR1s9VA9XLzJhivnM4fAoisadSsD6VgLwWNTuJOM8fmoDmrJmt0fCSkM+3r61L0vGOW+QYn46qkQBTVKo5tayArPKZ1wVttYUnRcbZdadcI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199015)(36756003)(38070700005)(26005)(6512007)(2616005)(186003)(2906002)(8676002)(54906003)(110136005)(316002)(86362001)(71200400001)(6486002)(33656002)(478600001)(53546011)(6506007)(966005)(8936002)(122000001)(4326008)(38100700002)(66946007)(66556008)(64756008)(66476007)(66446008)(76116006)(91956017)(44832011)(83380400001)(7416002)(5660300002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kwO0l4hUUBXeaGpj7S3QndmCEjG9NOd6ituvCRGQ/Bqg0fkpfiQkvINWAOIr?=
 =?us-ascii?Q?hNcJe3ctJWELiWs4cVU2QZeA3x2hJsRrfZkGXUDivyqh8T48xAMdZ9u8K++K?=
 =?us-ascii?Q?KNH4v6XsOzkqW0q/DcgxEdPzdZuZvtk82dKIDv+jnU12WDb7ey17B9Lqo+ja?=
 =?us-ascii?Q?oHU9fumNbz87yIe6j9NCo7npcCHWSIA+3SOq9TlYnaMDVsTcEy3rktBJ4zb2?=
 =?us-ascii?Q?mu5G+T1xvZFutxCw4O43PQfooPCfUQdUejMwdJCqpgdVIfSNVVG+LMPRbdTl?=
 =?us-ascii?Q?7D5IZFJI/E7cgJxeYIJKq5eQQmripTQBQs/sfNpYS3xzbB5JrPfvO6lJhgwJ?=
 =?us-ascii?Q?CQ1cpukn5KgjGpuyQP6+EkTc54y9QKcZKJBAROcJ/Q3cXM8O7qQumhHr6TYb?=
 =?us-ascii?Q?VL6Irnlek/wUiKaL+t0Rk55lZ2yxUg/LyawlNJAxYhBHJGS9cGuU2RNUmC4D?=
 =?us-ascii?Q?/mYToID+qJroiwKWrlrF1JpUmO/Ddmx9TT4y3yf2vVuT/jrmqLvuYTPU60VD?=
 =?us-ascii?Q?6AHgT5SeKZxA95WSiE11rxLzFKCZKMjQFPGjPYJ96GvgBJh90DrzAHKg39Ln?=
 =?us-ascii?Q?LMcerFC04Lw48CLtckNbjTOCMXOyyx+hPA355ydK1BKNuQfXZc5OReC7ohry?=
 =?us-ascii?Q?9DAOh1N10q/EnIvdtu3uy+rXdsJnE/P6sjS9kWbNwtJZk9lPzjbfRIkL73Sg?=
 =?us-ascii?Q?q/iTN8/xrF553WCcEY1E6o+4IaX1xNzfBweH3xa1wPioD+hVNYfyzb3kZK1Z?=
 =?us-ascii?Q?fv/aycYqShLeSUJDRRKNUDGgDaYMByAWWnjkEjJy8oUjWlN68cOiFZNoD4sb?=
 =?us-ascii?Q?fCdD96XcupP4uSfH9zW2tz/+JyJpcEr8UoV9HIiGwMPCIUsm5N8lml973Dbf?=
 =?us-ascii?Q?f4BGz9UBYzEVilXDIhOgF26fces5FIAG/TxF3ALWUmDIcFulgIlpJ2an6Svw?=
 =?us-ascii?Q?M8wnYnAyC8YaExeVafkk4a1t+Awdo6S61W2GMIdEeaSfU23WqGannxQ7OPEA?=
 =?us-ascii?Q?bCPLX8/1swC1vEpmC7m6QsxJfxfDa9v9jvnRwMTr+9p+DKs2uarqXG6mKSkF?=
 =?us-ascii?Q?Y6aOhArEKsQDiwCg92dvk9znGOUJtH0bTnXzHVuyj89UJyLH4Q75il3U+CuI?=
 =?us-ascii?Q?FpxbofMddIK3EAlEtZ7kv+y70bdxRZNFIwctQTcCgjPMchACZj11DPOwnx5c?=
 =?us-ascii?Q?GGUOq4FSwackPQ57A2296ODiPhk26KrnvLIxKpyj5kVjnlaOXSDcXcnbEPof?=
 =?us-ascii?Q?qqAbvk+G+oc1Qp5VqhRmbqKVrEj51e8QbfeFzzj7rycT4RKmNYB5nHYrVa7s?=
 =?us-ascii?Q?ESB1J/D9S8U7yv8CRyNfEj6hyTiCU43sp2ryRTAQqTyL4YKoq3uWHVv8jU9W?=
 =?us-ascii?Q?z1lbHx3akbeIcgtT1O8keZt1C8n7oM7jc2EPMY5bhGd+QrwoVp6xJoWmg6Qf?=
 =?us-ascii?Q?6XOfBVFu4zhLDdl8oJfVKAYb1WETCK2exhjaZIzzPWpHJAL3g7iNYEEK8cbG?=
 =?us-ascii?Q?ttVitxXgIJ43sEV+shApLdvWQl1Qoy7pPvYgGvMtKAIhnQO1rNiVl6s0wOst?=
 =?us-ascii?Q?lJEbJz/n568Nxa2N0qZ98zKdtRHJVWEZdvRlXW+gqt9DlCel0T6vdQ1Mdg7O?=
 =?us-ascii?Q?lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2D94D23D2990B84B90D67B3D2EF05FB8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b3d20e-3fb1-4315-16e0-08dad9fc3b1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2022 15:44:17.2625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dUpSL1qLL/vBQYAyHVGicg8uLXrta4Hlb8w9PZYyoNEyLbmxEC8kIUyWUrA/MFHxlFhseou8Da8f9FKF8GwznD11oJlG6l8hW98K/N+ckAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5896
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_08,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=845 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212090121
X-Proofpoint-ORIG-GUID: wjjGgnpYtUYqSFN5WzRGqYMqT-Q3u9Q7
X-Proofpoint-GUID: wjjGgnpYtUYqSFN5WzRGqYMqT-Q3u9Q7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Dec 9, 2022, at 3:26 AM, Coiby Xu <coxu@redhat.com> wrote:
>=20
> Thanks for your work! The patch set looks good to me except for the
> requirement of an intermediate CA certificate should be vouched for by a
> root CA certificate before it can vouch for other certificates. What if
> users only want to enroll an intermediate CA certificate into the MOK?

This question would need to be answered by the maintainers.  The intermedia=
te=20
requirement was based on my understanding of previous discussions requiring
there be a way to validate root of trust all the way back to the root CA.

> If this requirement could be dropped, the code could be simplified and
> some issues could be resolved automatically,

Agreed. I will make sure the issue below is resolved one way or the other,
once we have an agreement on the requirements.=20

> 1. "[PATCH v2 03/10] KEYS: X.509: Parse Basic Constraints for CA" added
>   a root_ca filed to a certificate to indicate the subject of the
>   certificate is a CA. The name root_ca implies it's also a root CA. But
>   according to [1], both an intermediate and root CA will have
>   root_ca=3DTrue. For example, the intermediate certificate of
>   https://www.kernel.org/ has "Certificate Authority=3DYes" in the basic
>   constraints. Btw, a root CA certificate by definition is self-signed,
>   so the following code in "[PATCH v2 05/10] KEYS: Introduce a CA
>   endorsed flag" looks a bit strange to me,
>    if (cert->kcs_set && cert->self_signed && cert->root_ca)
>        prep->payload_flags |=3D KEY_ALLOC_PECA;
>=20
> 2. Since an intermediate CA certificate also has root_ca=3DTrue,
>   "[PATCH v2 07/10] KEYS: X.509: Flag Intermediate CA certs as
>   endorsed" won't work as intended i.e. this following else branch
>   will never be reached,
>   else if (!cert->self_signed && !cert->root_ca)
>           prep->payload_flags |=3D KEY_MAYBE_PECA;
>=20
> 3. I see nowhere public_key->key_is_ca is set to true for an intermediate
>   CA certificate after it gains the KEY_ALLOC_PECA flag. So it will fail
>   restrict_link_by_ca even if the KEY_MAYBE_PECA flag is added.
>=20
> [1] https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.9

Thanks for reviewing the series.

