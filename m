Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CCD405C24
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Sep 2021 19:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241220AbhIIReF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Sep 2021 13:34:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:54568 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235813AbhIIReE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Sep 2021 13:34:04 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 189GYawq008988;
        Thu, 9 Sep 2021 17:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2021-07-09;
 bh=Vi9gswRKDNtjWaZUy4UrtRSSfckpex+tTNn443DUFzk=;
 b=A60BPpcL1LZk/kmPKQP6y2P7PAodVTB5cRmG1E3X30ugr/0LXpKtEEAs/Az2x5gTrbCW
 jrorOnRpJVut57htl/C+yE/GWHKjhSxm+FJ9dTS8Clj1NKnbViVhQ1FN9DHy3v1WRCXt
 iHBWZRnwImeg9e86Wxbvbup4oZGSu+Y/Mnw2h7aybhnc/fXUeHKEWM6nyc8PLyYGQxe/
 P3vtgRPVZE8g1LlL9pDsHDZIoggcLi9V1yJCpV8Kiv+ywGqFwyEOuWU8UHhY2eAYXl3/
 D8KaiaiZe2yykQydHs8G3VIocuJDd95krWTXNI9Yx1hMmcYURxAOhlNneRjIuKbHcJcW yA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=Vi9gswRKDNtjWaZUy4UrtRSSfckpex+tTNn443DUFzk=;
 b=bSYYqAw03AlyO5KquD9wnYaKncEuZxfZE+/nl2MssX104ZMvVswec1hQrcCVpg4xs8Hq
 w+0Zn3Bqe5+LFgkJeJliGqK0tSP3pV/U2NnRxX7s6WfincBIBjTtfkHgKVMvdNTHKl0u
 EnBJc0kfjLMGHXn32LQAszByjw+ULnIYfYQO88DkyHr7+ewkB6s9usa9nPXpVKWzZTx7
 QupOiYC01brdOOwcq/96Z2UctrSa0PVH/geFFJEnsODPzjDH65iAf13HG6s2CZ3FVDIG
 oWfj28k83+HqQ+UKK8QsdszdQGvp9XV4tikNJ8qZO5ySu8Blie53et3hlUej8rH2uq1N Eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aygy699tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 17:32:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 189HQsuO072243;
        Thu, 9 Sep 2021 17:32:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by userp3030.oracle.com with ESMTP id 3axcq3a09n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 17:32:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNrrsOsAjFuY00zN3cryxR+QNrdlS4GzVGwwcjtNTyf1GggWQhIPXnjjzqAoJPPlk81YGIXFHKe3/zFYx0s0GPR/4U8xD5J6Az38dqqAwP7cCBY4s++gec/P4QdJgC0MX0mO7Q3DEyJx65SapklYQNZ4SfRMIAjKQdTgIAJ+QPYYMSbxyl/odNTmgeMm0KrviQ7NSNuc5KUV41oxgHMz7WlOGDXQ59u6NyusB53FWMK4q1B7Zua88umcsk7GSRgVYaUmtdxC4ARi+0ieFKnFLwvursbGzfN+3C//FnPHuISdYqz7V21ZrZHiUvx7/S8Qcm2dkeneB1IQWYtDZW2MjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Vi9gswRKDNtjWaZUy4UrtRSSfckpex+tTNn443DUFzk=;
 b=ZUf15rVbacLDtHuQTmepLGAajYMhY3cIXyGQONu1kVGD7RwmgrJbugAkL2Arlvu8/bMCHNrFw0SYsBczVQ7nvwbB5Bw84ywvbtYPdR5RURZzNjKBNPEqTOxxI8K+f4zWR+ymsLXOWfXI1saCUjJhT3rX6XADs6RD7FIZ9saMzx9RBc59F0KbxdDE01FBo9CD8vMiGdNQf0qnLRl+oCfK8hK/k1K2QYsy9Ao5JCniGAi7UDDz86qgTXmgA31x0/ejDEBKe6ucZOPkrZWkIDQj5bGf4rSEfCIFogyVuZNoBkqd221DawU72JtWsEBNfMtDWiKXx5yDOs+p0dvjEkstCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vi9gswRKDNtjWaZUy4UrtRSSfckpex+tTNn443DUFzk=;
 b=e97RBRUji3CRlrxXfdxnTuEh43yI8zok01r8b0yvMsyDvMfH59TG97Cuk5UCY6kD9JSmlx0SCun7X2DQt/KRXDGqFXUDaVE1X7vUfj5l4tQi/Anb598IhsJRkTB+aGMO6VKBk4om1N5xvKVkUyfMfgCVRgkqVGNyq36uRLToXF8=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4072.namprd10.prod.outlook.com (2603:10b6:610:c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Thu, 9 Sep
 2021 17:32:13 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 17:32:13 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v5 01/12] integrity: Introduce a Linux keyring called
 machine
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <02024a370f3180e5a6668282e5843ab58bf2a073.camel@linux.ibm.com>
Date:   Thu, 9 Sep 2021 11:32:01 -0600
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>, jarkko@kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AE8C24C2-8F6F-4386-B804-532BE11F7F43@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
 <20210907160110.2699645-2-eric.snowberg@oracle.com>
 <02024a370f3180e5a6668282e5843ab58bf2a073.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: SN2PR01CA0039.prod.exchangelabs.com (2603:10b6:804:2::49)
 To CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from [IPv6:2606:b400:2001:91:8000::70a] (2606:b400:8024:1010::17c6) by SN2PR01CA0039.prod.exchangelabs.com (2603:10b6:804:2::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend Transport; Thu, 9 Sep 2021 17:32:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e53bcd3f-22cf-466c-a5d2-08d973b7c264
X-MS-TrafficTypeDiagnostic: CH2PR10MB4072:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB4072C0328A46CAE2C2A643FF87D59@CH2PR10MB4072.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6nbX7P+inSqax46Y8r9gldbTJ+DY51iKSWvY3uZxmeXxty0RWIgHuoL1xSocd8r/J/fwp1rRGHQFYx+MHBoI4vzt7YpzPnUXa7ZQsx2yG04AUIesk8vWySKKbt27N8cyfPbbmDyRBO/gm/RaHeXKLVgRtknuTZT3OOn6cbY5xcPEdcSL3i5DUM7IfSOzlQTpjoWW2fqUZAe1VCxb2j2GXpSh7eBzuhSPTELNWdaygp3hmmPH1lDOoY8L93WzkoO3PMDU5/sDkLrb/1QUOGfmNF2LJL9sogsWfEnE9jT1/BxpPFwrpupulxRgQWUxXNOo3pLnKMJk6UFIURgV/VEZZgDqqtTuEjfdepERlJKbxF4nqZ4XDH1b/Ei7myGDzwUgpAi3qCYpJUGcd1ONXcAcaHX+wofaUK54c1oz0ApoFiZ9KR8Rh4sxc4+AuvZaVemrOduX2v0yWvNUHxaPcBkzVWI4V/mvvKzN0433BNIvcw+nAQMdjaemOjIQ61cSS8TpAVD+6wS+5aTt4m3Mm/p+J8hrQ+c8obJd1w2zovaERyMuMN4+FYQZOKNXED3z0Wl+xAe0kBXT+7hE82pcY74Ek2161DvrG1N1C6+adtDqyb6WcfY7JQZyAkT7/ktcVqd8p8Z0JqkAIRgDWgMl8LpC0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(33656002)(316002)(8936002)(83380400001)(44832011)(6486002)(52116002)(66946007)(36756003)(107886003)(66556008)(66476007)(2616005)(6916009)(38100700002)(508600001)(5660300002)(8676002)(4326008)(2906002)(54906003)(53546011)(7416002)(86362001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VCtXSVRmMk5KNUNsYk9lZ2ZyYm5LS0JkdUNJclRWNzIrZmhDZlZZdi9FZU9q?=
 =?utf-8?B?ZUhaazVEOGk1azlKbDFkZU5oaDVrUGtiRUY3NG55b1RCd2grZWhvOW02WEda?=
 =?utf-8?B?U3RrTFBRaW5IZ3BkZ1JnWHB3RHFhdDJueEhXZGdDN0VBMTg2Y1JlSzdGQ1NG?=
 =?utf-8?B?WVZ6WHdxUTZpOUpOQXZyTFlqQW9DaVNOV3dkS2RpeW5ub01xSS9Hb1JYYkN6?=
 =?utf-8?B?cEUxWUIxOEdLRlcwYlNyclprV1l4RTd2OEo4ZkpmTE9wbE9yeGJKNFFvekFi?=
 =?utf-8?B?NVBuU1g4Wk50R0dqVWo1eGpROWZacVlReDcxZWx0LzFpdStsTmRQd01jazNl?=
 =?utf-8?B?TG9uUXBLSGx4Rk5YZk1tdlFPREtmczdDQ1d5azQvbVVIM05jejhaZFYrSUFK?=
 =?utf-8?B?dnliQVRYY09GQ3B6TDUxcGVJZVF4Ui9Oa01wZE54RDVzcWxEdWVjSFZaN2pP?=
 =?utf-8?B?eElpcndxVFd5Zlh5bzBaZG14YjRQQ21qMEN6dWNObWdTZWRGSHZialVwQU9S?=
 =?utf-8?B?RWl4bVVzUUt5a0lMNnBJRUVJcXpTZHh0Zm95TEQrSzB5R3BCUlJNU2c2N0RB?=
 =?utf-8?B?Z2h0eVEvV3gveWVKVDZXaGVaQVh2UFAvZHFCcXN3R1lhSm1CZzIwdjFjZzds?=
 =?utf-8?B?ZTgzeWlDeEhyRHlzS3lpaXhDRmZPWk1sQXlFajBHRDZnVFRUT0JrSHkxWWNx?=
 =?utf-8?B?N0d4SGt3dU9jaUZNZTdmbElkY0JaMWd1MHVZZ2p4cGFzb2dxeW1XcjhDNm0z?=
 =?utf-8?B?Q2daelBLWFVYWExiMkZubXRlMktXa2RvN1g3TU5qOUo5NFhPNm9jZlJNSENv?=
 =?utf-8?B?UDA5L2ZxYmFISE5IRXFLdzNnRWttZkZkdllZVCsrN0MwWURNVVhyK3FGWTZr?=
 =?utf-8?B?eTJuY1p3bFk1UGNEUTc2eVNneU52VHdIUmtKbzZhd1d3VHh3R0dST1pET0Rq?=
 =?utf-8?B?MStUVVFlZE81TWc5eHoyemRlNmtvQTh2M0NXU3VBQWNUTWV2MWNCWnhzNUxs?=
 =?utf-8?B?d0lEbFBhay9nNlNoOVRJLzUxUlJQRDNaNHR4dXRTTHBSY05IMzhYT0plY0Ni?=
 =?utf-8?B?K3Q3Y2w2c0hTbFU2dTlzQXdvYkhKbzJaV25WS0F0WVNiWURzbWhLR1N0STF3?=
 =?utf-8?B?Tm1NUDlXVm9QSUlxUVVaalAvT3BZWlVUemExZUZTenJWZ1BmOVBuMnVOcmxw?=
 =?utf-8?B?UEM5dytOYVdiWHhwRURIMXlPaXhLbTI4blQvWldmY0lPM2N3SzBpblFTNTcx?=
 =?utf-8?B?MithM1RtdlFYdCtpcDRFNU1KMDhxUzR5QWp5MDlpdktlanNtNTloaDQzR3Qr?=
 =?utf-8?B?M1A5bytSSkhzeGNnNGJTM1MzTEg2d2RuMytaNUxhLzl6eVYvSHJBK0tRNU0w?=
 =?utf-8?B?dS9vM2puS2ZsUk54eGRyMWd4RWVEN2dEUjVkem9vTTFwZ1lIK0tOb3dLK1c5?=
 =?utf-8?B?TCtJR0VUTk12VmF3bGhUOUp6V2M3QkpINFZqajEra3d6d01sRUR0K2JuNnNK?=
 =?utf-8?B?UXFrbFVHckI1RFVKMVJRQWdvV0owcUUrc0FyUW12cWZLV2xRdGlxOVRybW1B?=
 =?utf-8?B?UE0xRjlSc3BNS2Q4MWNhREtvMUFJSmhrQ0Jxa1E3VGIvUFJFdjRXK3ZHNUpB?=
 =?utf-8?B?ZDNkYzd5aTBWQldBRDVlSDkrS1YyS3o2N0Z4VnZaVDljcHVha3RmZHhrWjBx?=
 =?utf-8?B?TUlEK3dtRUFVRldHVVBMcjZsS21IVStqanNoUmNuQ21BWmxBSWJ1TDluUlpv?=
 =?utf-8?B?R3hxSUd3a3RnY05mQzJrZUR1WnhMdTBzM2Y1MWdLdHVwOGdFSnROS3dIdVdl?=
 =?utf-8?B?TldmdHp1WWNuQ05LN05WUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53bcd3f-22cf-466c-a5d2-08d973b7c264
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 17:32:12.9680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMlPjUEEQTGW7klf4b5pCJ1g4jEP4/5WuTYVwSHr/fJx3SFEA620fc/nMKBQTcFauxewZkhlXfiSjCSOpIONAKaqPJfRHzhqrJOa4SaPxCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4072
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10102 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090107
X-Proofpoint-GUID: eNNrcMF7Yk2FybptJEEMfkjNiw6nP_-U
X-Proofpoint-ORIG-GUID: eNNrcMF7Yk2FybptJEEMfkjNiw6nP_-U
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Sep 9, 2021, at 9:19 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Tue, 2021-09-07 at 12:00 -0400, Eric Snowberg wrote:
>> Many UEFI Linux distributions boot using shim.  The UEFI shim provides
>> what is called Machine Owner Keys (MOK). Shim uses both the UEFI Secure
>> Boot DB and MOK keys to validate the next step in the boot chain.  The
>> MOK facility can be used to import user generated keys.  These keys can
>> be used to sign an end-users development kernel build.  When Linux
>> boots, both UEFI Secure Boot DB and MOK keys get loaded in the Linux
>> .platform keyring.
>>=20
>> Add a new Linux keyring called machine.  This keyring shall contain just
>=20
> ^Define

I=E2=80=99ll change this in the next round.

>=20
>> MOK CA keys and not the remaining keys in the platform keyring. This new
>> machine keyring will be used in follow on patches.  Unlike keys in the
>> platform keyring, keys contained in the machine keyring will be trusted
>> within the kernel if the end-user has chosen to do so.
>>=20
>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
>> ---
>> v1: Initial version
>> v2: Removed destory keyring code
>> v3: Unmodified from v2
>> v4: Add Kconfig, merged in "integrity: add add_to_mok_keyring"=20
>> v5: Rename to machine keyring
>> ---
>> security/integrity/Kconfig                    | 11 +++++
>> security/integrity/Makefile                   |  1 +
>> security/integrity/digsig.c                   |  1 +
>> security/integrity/integrity.h                | 12 +++++-
>> .../platform_certs/machine_keyring.c          | 42 +++++++++++++++++++
>> 5 files changed, 66 insertions(+), 1 deletion(-)
>> create mode 100644 security/integrity/platform_certs/machine_keyring.c
>>=20
>> diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
>> index 71f0177e8716..52193b86768a 100644
>> --- a/security/integrity/Kconfig
>> +++ b/security/integrity/Kconfig
>> @@ -62,6 +62,17 @@ config INTEGRITY_PLATFORM_KEYRING
>>          provided by the platform for verifying the kexec'ed kerned imag=
e
>>          and, possibly, the initramfs signature.
>>=20
>> +config INTEGRITY_MACHINE_KEYRING
>> +	bool "Provide a keyring to which CA Machine Owner Keys may be added"
>> +	depends on SECONDARY_TRUSTED_KEYRING
>> +	depends on INTEGRITY_ASYMMETRIC_KEYS
>> +	depends on SYSTEM_BLACKLIST_KEYRING
>> +	help
>> +	 If set, provide a keyring to which CA Machine Owner Keys (MOK) may
>> +	 be added. This keyring shall contain just CA MOK keys.  Unlike keys
>> +	 in the platform keyring, keys contained in the .machine keyring will
>> +	 be trusted within the kernel.
>=20
> No sense in creating the ".machine" keyring, unless it is possible to
> safely load CA certificates on it.  At least for the time being, this
> should also be dependent on EFI.
>=20

Will also add a depends for EFI

>> +++ b/security/integrity/platform_certs/machine_keyring.c
>> @@ -0,0 +1,42 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Machine keyring routines.
>> + *
>> + * Copyright (c) 2021, Oracle and/or its affiliates.
>> + */
>> +
>> +#include "../integrity.h"
>> +
>> +static __init int machine_keyring_init(void)
>> +{
>> +	int rc;
>> +
>> +	rc =3D integrity_init_keyring(INTEGRITY_KEYRING_MACHINE);
>> +	if (rc)
>> +		return rc;
>> +
>> +	pr_notice("Machine keyring initialized\n");
>> +	return 0;
>> +}
>> +device_initcall(machine_keyring_init);
>> +
>> +void __init add_to_machine_keyring(const char *source, const void *data=
, size_t len)
>> +{
>> +	key_perm_t perm;
>> +	int rc;
>> +
>> +	perm =3D (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW;
>> +	rc =3D integrity_load_cert(INTEGRITY_KEYRING_MACHINE, source, data, le=
n, perm);
>> +
>> +	/*
>> +	 * Some MOKList keys may not pass the machine keyring restrictions.
>> +	 * If the restriction check does not pass and the platform keyring
>> +	 * is configured, try to add it into that keyring instead.
>> +	 */
>> +	if (rc)
>=20
> In addition to the comment, also test to see if the ".platform" keyring
> is configured.

and will add this too. Thanks.


