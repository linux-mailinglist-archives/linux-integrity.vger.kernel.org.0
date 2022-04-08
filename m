Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF4C4F998E
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Apr 2022 17:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237622AbiDHPe2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 Apr 2022 11:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbiDHPe1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Apr 2022 11:34:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FCA3221D1;
        Fri,  8 Apr 2022 08:32:24 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 238F3u9N024505;
        Fri, 8 Apr 2022 15:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sQ1Kfo1tptzfFpG7Sw4UO/l/gvkL2Ehgwljs/7e5Wq8=;
 b=O19e1bJMtheLAbIs/xipjj1chOVs8KPPLOzLNzD7Lo+uBBCQP61sWGSwkoo6+i0qa3RP
 ATkWoHCigPXnOB9dkL4J17WDy8UOGbL50MURnYnDe0n5wMGFQUsc5uaH9nKBUtJgVSTs
 ba23+F2EdlwynskupiadkpYCkfURJYaUP+HQ49bduyKM//C5Nis9YDzqvj3/O86UBGu6
 exE566sHuN5bys3AmqMPzN9kvPKj5K7krSkT7BdV4dRDOOW5inKNvv+5MOe360WTAgFY
 Iy8IoAYZXZ2CFzQoiaumrhjYoG0dRiE5r/X5IJ6m2btIJqBYpvf7wB0aOypai/5bN6qb lQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1tftnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 15:31:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 238FV9dM029875;
        Fri, 8 Apr 2022 15:31:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f974fffe6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 15:31:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtK4iuDgQU9sLiRusPGePPHmMa8/VpHxQd7mk+p5HRZ/ilMUjDbqe5fGr8VpFjb1eSdhraajaJFNSuj5m9mIq8f9+/C7hrCpZR68RivR+0RCFb1owVLSq2QULCdZ6nZMYpf8RlMzbS8dLexOxk2N60QRnGLY9Jp5LSNZH+qu1xopZEko4AXFz6rwo6gZAXK97RsxthDY0Rem8eYIEC2T2pwXOZXtqh5wfUVvk5fo//CcqKjjHP6Ogc2GDqYLNdxxpkS+3Leewa6W5sD6si67ZIayr8p8hvKDISpW168fCe+gtNr6zmmUSdVdO4shOtuf5H4NBxkKazgGK+o+bX7mFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQ1Kfo1tptzfFpG7Sw4UO/l/gvkL2Ehgwljs/7e5Wq8=;
 b=jdFYdxbsftPia5UOW66YKlgkixDA+URKkwowsFM+KsCFsGBmYURO7W3TSJaf26hGnKHcL9wdiraa7q2HbPDxMuDSuly7OytcHlPa6PAJRAHmCa+5lTBvmFk5wXeJt0RVZ1RhWgZdQaAA8Vjvv1rt0kn9bCBbf2DdNkZL1EoE7Uuz6KX/Do6XrZvRVP8lRP/mKJm7taMKnVEtVWE98+nan0hyBWmyJDk4tvIcHVFn7vPrrFK60Ln9Y3GN0Hyu6LVAtYvWkT33XttAknNeKENZsJD97oIdpKfCcPTczKto6S5vICckWJvJDATVY1Vf9icx8yy7I8Lo88rEmWei/xkvHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQ1Kfo1tptzfFpG7Sw4UO/l/gvkL2Ehgwljs/7e5Wq8=;
 b=iSZW0gs2BqPmuf8qOz5//zS1zM+jBjxBwHC257XEKw5kPqqmmdOXbryjFXwm7vrbBsZW/ulIg1tPLbXwrDNZcYV4IOkSPfSl5Lcapxykp4EjptwDRlD5x3aKxFoJUSJAMVhISKl44ywpYCXRNfQEyYu73DS5cai8iCrgL5VjCp0=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SA1PR10MB5823.namprd10.prod.outlook.com (2603:10b6:806:235::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Fri, 8 Apr
 2022 15:31:24 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55%7]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 15:31:24 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     David Howells <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
        "nramas@linux.microsoft.com" <nramas@linux.microsoft.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>, "tiwai@suse.de" <tiwai@suse.de>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 2/7] KEYS: X.509: Parse Basic Constraints for CA
Thread-Topic: [PATCH 2/7] KEYS: X.509: Parse Basic Constraints for CA
Thread-Index: AQHYSVkr8zu99hcZ3Uq7FMDAwEqlg6zmGjCAgAAOhYA=
Date:   Fri, 8 Apr 2022 15:31:24 +0000
Message-ID: <55121686-C2C9-484A-BA01-830C7A60E8D1@oracle.com>
References: <20220406015337.4000739-1-eric.snowberg@oracle.com>
 <20220406015337.4000739-3-eric.snowberg@oracle.com>
 <b28ea211d88e968a5487b20477236e9b507755f4.camel@linux.ibm.com>
In-Reply-To: <b28ea211d88e968a5487b20477236e9b507755f4.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48ab8495-5a4c-4090-a0a6-08da1974d72c
x-ms-traffictypediagnostic: SA1PR10MB5823:EE_
x-microsoft-antispam-prvs: <SA1PR10MB582399B51A947DFD9467BB7D87E99@SA1PR10MB5823.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9vp99VeswZCvuHhZZ/RolfbmJ2z8rYdoR7dsuhxQ+2ILvFUw0BusQrNZzofzfXvMtjY/iIteu2ZI79VMA4xxMDJfHEHmvNvvwOaAD0NcOXAzxJtt4pkr4jNPvczQ0wJclTf08hzMl3Scbi6vkTqrTObmNXjETMHO+CJ+Gn8w74Y/RJ0XArPFfvUh8RzZHMWBX1K23iJK1oT8yD1Cb3fJAF45nedy8dgdBVMxbUaSHLM/TPjxK0WXdsRqI5pTamDkVjkYFhomRN4RQieNJlwJk3EdE8J64EI0OjplmrdzFqdZvvNiKS1veVji1ljCPypuiORO37mzYN0FCnc5TR4TwK12Q58KmvmNvDVP9KfizyQvqtEBEddwpkuFJs713Q/uAjeADGWlpzmJwY6mfhJSzyHNHgnkfqQvu35szCAXrOhXWnMRz4DSSIgNx890BgmyXwFvNW02VgJvdrRBl98MFfl8iKQOrxBkiY4z3XR6KWG8pVg7Usaav3nGrp6ric93iFpUD3LpWjKS7wzF9VHbJinRzFxd4knTzuEkyDft1UEC33qmgw5/e1RqaiLCn16qLG8pYpHLbl2oU0pYU9vtHIx8mJGVyiBHAJfeuwtxpw8gu+o7GXnqZOCzbveWRaMWTnGSTzJM+czX8f8uY9Tf8nhRjcV/OuxdI3RyJOd7oF/910x9PqOGJfP6tlTpqctJ6X+lOnqqA4BuS0Mz5EHdGUedIdnN++LS3Hm1rqdcO7nJ7CVQ7SFlQ4TGtlHNX5HR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(6512007)(66476007)(6506007)(4326008)(38100700002)(53546011)(38070700005)(8676002)(6486002)(64756008)(8936002)(6916009)(33656002)(66446008)(5660300002)(54906003)(36756003)(2906002)(44832011)(2616005)(508600001)(186003)(91956017)(66946007)(86362001)(76116006)(66556008)(316002)(122000001)(7416002)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlIzQ2wxcWw4ZDk4OU5oczc0N1J4T09WSGNGWC9ycVNmbkY2aWxSd2FoV1Vx?=
 =?utf-8?B?MFFKTmFaUmFCaXBCS1d2UzlxZENuaHdzSWVxcmh2ODIyUHFBdUk2ekF2dis5?=
 =?utf-8?B?RVBXU1FSdXViQkc3S2tsUkp4TGludWdRZG82SGZGZWZSL1hJTUVUYXRPR3NX?=
 =?utf-8?B?QjV6ajROSUk0NlYzSllBSlhiZGV3K2pmT1E2L1BEd1h5OGpSaWFsTUY3T2Yy?=
 =?utf-8?B?QS8vOVNnQmJldXU0K3N6cVdUZXBibE4wMy9hZExKU0RMbmlxQ2lQZ0czWFJU?=
 =?utf-8?B?Y1pRNmduY0huY1J1NVgveC8rOGkxK05FdWxzeGRyWU1NNnZhRE9NaFdHU1Fv?=
 =?utf-8?B?MDFBY2UzdEQzYm0xV0NocmkxQlZTWXJucHFSbjZEYWlmeGxhNGRkQmlKYjFQ?=
 =?utf-8?B?aXgvZEgzNkFDTDBjb1VMelZ3eWJoTEkxcTZqUXg2dCtPT3Jtbnl5T0U4Tzha?=
 =?utf-8?B?QlVwc0dQa1hFelBWcWNmdnpNbVY5ZjRydzg4cjZITVd2UnZlNnpqSTJDbWc4?=
 =?utf-8?B?anczVTd2YW1wenZiYm5XSm9QY282a28xMWZKdEpwc0Jxc3dZMjhVeExkTnN6?=
 =?utf-8?B?bjlBVVBHV0hNVC9NUCs0aVdnemxIcEVzNDRjRWJaaFhZOHUzN3k0SzZLSlN0?=
 =?utf-8?B?cUR5QktxREh3dEFXMGc2M3krcnZjT291OHpSTjZFUXBObzdtL2pmVVg4Zm80?=
 =?utf-8?B?bkQ5OWhmbk1UMFZvSDZqa0RRUVRoQzNac2J3VDlRT3M5UjltQ1dnN1E1d1Ru?=
 =?utf-8?B?Vi9nVytEcHpiOWsyeEVGTjJuTkxXOVk3NS9jT2YweHNDNFVJTzdYL29rUlZy?=
 =?utf-8?B?bG83TVh1aVR3cyt6V0U5QmtDaXRpL3FNRjlMUVhpRjd5OVhmZ3VNTm15a2ph?=
 =?utf-8?B?NVVmMnRUUE8yb1F0bVd6RkNzZWFmZmlsQWtVU29kdjFHWkdvTzkrK1VFandS?=
 =?utf-8?B?TFBjdllNYnpYMm9DcmpnTGk2dm9qeHJXUnZaTlNFb0VEN09xQTRqdzVwVFdR?=
 =?utf-8?B?bG1tNFZzY3NERjJwbDNVcWFKallYbGRkRXlQWllJdHNWY2lyNklpRS9Tallq?=
 =?utf-8?B?NVRGNndRZXdidGJFd1VRMjNHM05pd0FJd1kyQUtGcWd0RXNTelJ3c21ERVZF?=
 =?utf-8?B?R3g5TTNZcFFSSGZqMmdhaVJyOHBBUEJqalgwTW1FdTBRYk5jdzF1Y0ZwOUxE?=
 =?utf-8?B?MTNYT1R3TEIxS1NGRWFWU293eUdERU12ZnRCTGY1VVZoNTFJazgrbitXYkJ0?=
 =?utf-8?B?eExpc0JRdzd3MElGRFRyWUhKTDRTYjVWdnIxWGlyZzhMZjhKN2RVWGppczRp?=
 =?utf-8?B?U3NJT2ZvNlZGWVVPZTBlRndCUFVESWNlSjZPcVU4Znl4SlMzL0M3MEM0Tjc3?=
 =?utf-8?B?b1NoakxaM2lGcCtXdkJGdzIvSlZIRzdERmMzUkwzSGFKOUZkaHliU0VEd1lU?=
 =?utf-8?B?WmgwN0ptR2xWa3IzWnBTc0lmVU5CWU54Rk85RkxwQmlhMnNXV2Y5VGNDL0pv?=
 =?utf-8?B?NnZZN09OeWRScDVZNWFIVWlaSWxCai9RZWhoU0w5T2lDRlQvZ0YzRWZwYlFv?=
 =?utf-8?B?NFgyb3NWaHRXZFM1NGVkM3UzMHg4RDIvRnBEbjFNeUVuQkdnRkZqQjJRVGtr?=
 =?utf-8?B?UU82bFZVOGpvQ3JrZ0hnSm4zOUtib09MVk1kRVJXeFl1OVkwaW9hbFZPV0pZ?=
 =?utf-8?B?dlZKSFBLcmZISEhYUjkyM2tHR1lQZFlITkcwY1FaZjgrZzFuM1VURkFaeFV1?=
 =?utf-8?B?QlZzcUdMYTdPY2R4V1BneldsR2VnMjVwTUxGc2VQc2ZtYjdqZzJMR3FscWtl?=
 =?utf-8?B?ZWpLenFJaDN3Ym5iRWJRMHZsQlVuRVpSWCsvcVMrcTB3K3Jtb0dXeSswaG1R?=
 =?utf-8?B?S1ZJZmhhdzZZaGhVODVKL0V1cGZrWXBUeEZWQS9ZYWxsbzBCUDNmcnI3clpR?=
 =?utf-8?B?b3ZLYjBBQXMxT3p0ZXBGa0dOeXF6aDBiQkNtRlFzQnlLTFdxcC9tTG56dGNK?=
 =?utf-8?B?T2dlWkh6WG9qN1k3NTAxR3dTdzdqRis4aXV4eG1ZSFJUdWxMYWNCRG5XbzBl?=
 =?utf-8?B?aWtxdmtBQVJRRGpFS1hiL25UL2pFUkhXNTlZUnZMSngxUlZLMnZXanpuNTRH?=
 =?utf-8?B?N3FhTnc5Y2RWN0hDd3hjYXRtUzN0TXZUME85cldIQ2pLY3VLanFaMEZVdzNv?=
 =?utf-8?B?aW1sT2Flb0N3Yk9sNFNMeURCeDQ3WXRlOEQvNGp6ekk4SVNaKzN5TTMrekU4?=
 =?utf-8?B?Qys1bU9xRnIrL3BuSlZrSWpPRDFGOXVoOGl0aWI3czFhcG55OXhzK3JjbXda?=
 =?utf-8?B?U0F4d0E0WjV0bG15d2FIdTZlVTloRVVVTnc0UjNXRXBLaU5XNEwyRUo5Q3Rt?=
 =?utf-8?Q?ysRMUotJSOWb/8fQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15773CA6A34E2445880A76780A3D298B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ab8495-5a4c-4090-a0a6-08da1974d72c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 15:31:24.2648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VBXqZWSba7TLg/yqjF/17B1G08ZE5ehnoVKYh3T68EwzUrD1lpCOiYBd9Z7laBnPNY8JudsekA1csiWT23C/SpFEpPqelLMnAC/eGVL/3Ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5823
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-08_05:2022-04-08,2022-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204080077
X-Proofpoint-ORIG-GUID: xCrqUPYGcrlFRNgH_SZ53W-jNR42vxJj
X-Proofpoint-GUID: xCrqUPYGcrlFRNgH_SZ53W-jNR42vxJj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gT24gQXByIDgsIDIwMjIsIGF0IDg6MzkgQU0sIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4
LmlibS5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCAyMDIyLTA0LTA1IGF0IDIxOjUzIC0wNDAw
LCBFcmljIFNub3diZXJnIHdyb3RlOg0KPj4gUGFyc2UgdGhlIFguNTA5IEJhc2ljIENvbnN0cmFp
bnRzLiAgVGhlIGJhc2ljIGNvbnN0cmFpbnRzIGV4dGVuc2lvbg0KPj4gaWRlbnRpZmllcyB3aGV0
aGVyIHRoZSBzdWJqZWN0IG9mIHRoZSBjZXJ0aWZpY2F0ZSBpcyBhIENBLg0KPj4gDQo+PiBCYXNp
Y0NvbnN0cmFpbnRzIDo6PSBTRVFVRU5DRSB7DQo+PiAgICAgICAgY0EgICAgICAgICAgICAgICAg
ICAgICAgQk9PTEVBTiBERUZBVUxUIEZBTFNFLA0KPj4gICAgICAgIHBhdGhMZW5Db25zdHJhaW50
ICAgICAgIElOVEVHRVIgKDAuLk1BWCkgT1BUSU9OQUwgfQ0KPj4gDQo+PiBJZiB0aGUgQ0EgaXMg
dHJ1ZSwgc3RvcmUgaXQgaW4gdGhlIHg1MDlfY2VydGlmaWNhdGUuICBUaGlzIHdpbGwgYmUgdXNl
ZA0KPj4gaW4gYSBmb2xsb3cgb24gcGF0Y2ggdGhhdCByZXF1aXJlcyBrbm93aW5nIGlmIHRoZSBw
dWJsaWMga2V5IGlzIGEgQ0EuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgU25vd2Jlcmcg
PGVyaWMuc25vd2JlcmdAb3JhY2xlLmNvbT4NCj4+IC0tLQ0KPj4gY3J5cHRvL2FzeW1tZXRyaWNf
a2V5cy94NTA5X2NlcnRfcGFyc2VyLmMgfCA5ICsrKysrKysrKw0KPj4gY3J5cHRvL2FzeW1tZXRy
aWNfa2V5cy94NTA5X3BhcnNlci5oICAgICAgfCAxICsNCj4+IDIgZmlsZXMgY2hhbmdlZCwgMTAg
aW5zZXJ0aW9ucygrKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvY3J5cHRvL2FzeW1tZXRyaWNfa2V5
cy94NTA5X2NlcnRfcGFyc2VyLmMgYi9jcnlwdG8vYXN5bW1ldHJpY19rZXlzL3g1MDlfY2VydF9w
YXJzZXIuYw0KPj4gaW5kZXggMjg5OWVkODBiYjE4Li4zMGY3Mzc0ZWE5YzAgMTAwNjQ0DQo+PiAt
LS0gYS9jcnlwdG8vYXN5bW1ldHJpY19rZXlzL3g1MDlfY2VydF9wYXJzZXIuYw0KPj4gKysrIGIv
Y3J5cHRvL2FzeW1tZXRyaWNfa2V5cy94NTA5X2NlcnRfcGFyc2VyLmMNCj4+IEBAIC01ODMsNiAr
NTgzLDE1IEBAIGludCB4NTA5X3Byb2Nlc3NfZXh0ZW5zaW9uKHZvaWQgKmNvbnRleHQsIHNpemVf
dCBoZHJsZW4sDQo+PiAJCXJldHVybiAwOw0KPj4gCX0NCj4+IA0KPj4gKwlpZiAoY3R4LT5sYXN0
X29pZCA9PSBPSURfYmFzaWNDb25zdHJhaW50cykgew0KPj4gKwkJaWYgKHZsZW4gPCAyIHx8IHZb
MF0gIT0gKEFTTjFfQ09OU19CSVQgfCBBU04xX1NFUSkpDQo+PiArCQkJcmV0dXJuIC1FQkFETVNH
Ow0KPj4gKwkJaWYgKHZbMV0gIT0gdmxlbiAtIDIpDQo+PiArCQkJcmV0dXJuIC1FQkFETVNHOw0K
Pj4gKwkJaWYgKHZsZW4gPj0gNCAmJiB2WzFdICE9IDAgJiYgdlsyXSA9PSBBU04xX0JPT0wgJiYg
dlszXSA9PSAxKQ0KPj4gKwkJCWN0eC0+Y2VydC0+aXNfcm9vdF9jYSA9IHRydWU7DQo+PiArCX0N
Cj4+ICsNCj4+IAlyZXR1cm4gMDsNCj4+IH0NCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2NyeXB0by9h
c3ltbWV0cmljX2tleXMveDUwOV9wYXJzZXIuaCBiL2NyeXB0by9hc3ltbWV0cmljX2tleXMveDUw
OV9wYXJzZXIuaA0KPj4gaW5kZXggOTdhODg2Y2JlMDFjLi5kYzQ1ZGY5ZjY1OTQgMTAwNjQ0DQo+
PiAtLS0gYS9jcnlwdG8vYXN5bW1ldHJpY19rZXlzL3g1MDlfcGFyc2VyLmgNCj4+ICsrKyBiL2Ny
eXB0by9hc3ltbWV0cmljX2tleXMveDUwOV9wYXJzZXIuaA0KPj4gQEAgLTM4LDYgKzM4LDcgQEAg
c3RydWN0IHg1MDlfY2VydGlmaWNhdGUgew0KPj4gCWJvb2wJCXNlbGZfc2lnbmVkOwkJLyogVCBp
ZiBzZWxmLXNpZ25lZCAoY2hlY2sgdW5zdXBwb3J0ZWRfc2lnIHRvbykgKi8NCj4+IAlib29sCQl1
bnN1cHBvcnRlZF9zaWc7CS8qIFQgaWYgc2lnbmF0dXJlIHVzZXMgdW5zdXBwb3J0ZWQgY3J5cHRv
ICovDQo+PiAJYm9vbAkJYmxhY2tsaXN0ZWQ7DQo+PiArCWJvb2wJCWlzX3Jvb3RfY2E7CQkvKiBU
IGlmIGJhc2ljIGNvbnN0cmFpbnRzIENBIGlzIHNldCAqLw0KPiANCj4gVGhlcmUncyBubyBuZWVk
IHRvIHByZWZpeCB2YXJpYWJsZXMgd2l0aCAiaXNfIi4gIFNpbWlsYXIgdG8gdGhlDQo+IHZhcmlh
YmxlICJzZWxmX3NpZ25lZCIgc2ltcGx5IG5hbWUgdGhpcyB2YXJpYWJsZSAicm9vdF9jYSIuDQoN
CknigJlsbCBjaGFuZ2UgdGhpcyBuYW1lIChhbmQgYWxzbyB0aGUgb25lIHlvdSBpZGVudGlmaWVk
IGluIHRoZSAzcmQgcGF0Y2gpIGluIHRoZSBuZXh0DQpyb3VuZCwgdGhhbmtzLg0KDQo=
