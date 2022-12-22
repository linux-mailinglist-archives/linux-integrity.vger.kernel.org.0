Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960D7654417
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Dec 2022 16:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbiLVPRo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Dec 2022 10:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiLVPRV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Dec 2022 10:17:21 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4912185;
        Thu, 22 Dec 2022 07:16:25 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMDOJli015990;
        Thu, 22 Dec 2022 15:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ifi/R3wDES3qmdcPISt3rV/RFowWHX9GcFxEqX6C+08=;
 b=tZ2xpo+LU7ZiRk1VJqnswtoYCTsadBXUuG25F//pckK/rMM1pJn2iIN2Dh2jtGiJCTNN
 Y5zDbZCeByrfKOMjhcUm61N/2Bz1xdP8lZsSD7UgIgOkwdjRZ+mwQa7tbbTmqyVTdQok
 oIqSGvrUmlcOVpEds/xjWmmNYdpf8ahe6urI9DWOX4UCP/wI/NulIiL11T+B9azboBuZ
 LqdyxhROzl5DPJ03Iux0jcJlqLWynlQPNd3DiOSIjIz7apsOTg52+wwTjrC/AOfKcvBR
 RhOrMh/U2TX4wrzUi2keccQTYonzRiJmqxfi2EO0UmP7b3L1oC8p+qzbZqKLb1Gt5bH+ Lg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tpburg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Dec 2022 15:15:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BMDXktZ035348;
        Thu, 22 Dec 2022 15:15:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mh47ee0v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Dec 2022 15:15:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQDW4IPxVqWB9Zo2JATjPRFV2RjAh8DhyrXfAX30DadToPaS6IC2PBkSPqPMxkTlzCGLwNJT8GPratqYO96c8h8Mdg9jJkunLr348ApsbBIwb0BZtXZK+KRuMMew1lrWlJqHBXUFUqqqjFsz8HxiIcNRfz4ctzD3mN/zqMV9JZ0c8NRKalI/8/KJoKpN1vBRPWm+MVme0rErp1YobxtFytMWFDLar7iOrW/MRxOuh2iZX2m0BH3YQQoV3RPDUliHuQraV9HJ/TnDiHwlG04zzjqt0S+qx42tiHSCTuisJSpI2ypudUhOXnIGhPHxtv4NEnkJJMLqyMXRWBrncropIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifi/R3wDES3qmdcPISt3rV/RFowWHX9GcFxEqX6C+08=;
 b=SwStVMTcd+Hcl8snpm7nJsAAX23/NKTfmuYpr3F3mBNFeEH6vH09yV3Dpa9xPuQ0iQPA08M0AR42X9SOkiFW5K7anlZqiTNN96qYhCz+5/MMe8i4ujvZ5KvRS9G6V1ewPd5LV0V1oI+M8CFrjqS74FPYWxMVI1SNI+o1y7n8KToU8iykWwM6SFUAAHrcXgX4hpanud7ASCs35wcioaZAVQCDbCT+ZunmdO+YEa0wQDLt/f/Eo2M6McNLP2Xbuyp3QYRnCzP85hITCj9d3q/SOMGwWlnnH1qLQuHEihVlcni2K+e/MmuWNHXv76vLVfBttkNPdZbynYyFqpAv4YuXwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifi/R3wDES3qmdcPISt3rV/RFowWHX9GcFxEqX6C+08=;
 b=IiAiMv96lKXXyW5U069Hwnm/efxVmWI3eQsd3PuXmbtbhoBTzyV1kCgILOrpGofFsR9Gas9dLJRTD/fynLfoZj4+eyt6zfJ6OCV2QkNQkkpWEtGmxdAXVV5eYNSyC4tFZWojUqYDWKUU9OMXGzW7ELAXM1qZdCUmOu1n68RTpPY=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by PH7PR10MB5745.namprd10.prod.outlook.com (2603:10b6:510:125::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Thu, 22 Dec
 2022 15:15:50 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 15:15:49 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     Jarkko Sakkinen <jarkko@kernel.org>, Coiby Xu <coxu@redhat.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>,
        "noodles@fb.com" <noodles@fb.com>, "tiwai@suse.de" <tiwai@suse.de>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Elaine Palmer <erpalmer@linux.vnet.ibm.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 00/10] Add CA enforcement keyring restrictions
Thread-Topic: [PATCH v3 00/10] Add CA enforcement keyring restrictions
Thread-Index: AQHZD1PCFegbrli1zUCp/3TmJTzIr65uvzMAgABmOoCAADsnAIAACGGAgAAJu4CAAAvJAIABEiUAgAMHQoCABR0rgIAACaUAgAFTMgA=
Date:   Thu, 22 Dec 2022 15:15:49 +0000
Message-ID: <6AAEC343-E581-4355-ABD8-FE32A1BD16D8@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
 <b8e54d077da633132eb6da03ea536face095a425.camel@linux.ibm.com>
 <4CE6F17D-9D87-4024-9E1A-FDFE7C29D5FC@oracle.com>
 <1c51910a35a1d113256494827fd66ccc7473632e.camel@linux.ibm.com>
 <17855993-519C-4DAC-B62F-9DB473CF249B@oracle.com>
 <7df94da37c100c160436892a6996ba30e3fd6dc8.camel@linux.ibm.com>
 <21E52C3E-0778-4908-AF44-F65D57BEC4E0@oracle.com>
 <20221216140648.h32gn5qf3igorpzi@Rk>
 <2d75dfd105f8558ecd1074d64e4252ddd63b698b.camel@linux.ibm.com>
 <0DAFCFC7-29EB-4481-8FF7-616336383378@oracle.com>
 <0fb737ab42ef093f7031a80c8a73f582b1d5c1ae.camel@linux.ibm.com>
In-Reply-To: <0fb737ab42ef093f7031a80c8a73f582b1d5c1ae.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|PH7PR10MB5745:EE_
x-ms-office365-filtering-correlation-id: 63b482fe-2c7e-4858-3bf8-08dae42f68c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JHZjV68vnLR6dUW/oaC1h0x+zVl4dhpAAcBdH67PY2vADWglmznuShLM6AN/ZbiibY8MJVyCT4GdyiqTDJVMpvidEyQom4ipjlQl90NHovbm2isicM+AlmUAVArSHc2foMilO+tJ8WjIOrX7gdKFY5aaS9Nu357bJhqoHLawHET7m/6uRNf3HH19Qhk7qFfypSca9g9hKEYUWeS1Mryps1R8kqLlzuokX9346AkamLxRXhSqOYxKCfXzfnmShZvsfskQZDA2GNRaUnGhIQJo/aJC9PSQcA/+ifl7YrAbozPI/rKNaEYI/0OliwZCj+gxWrGuH5kJP/TBgcS5vNxO5/8UNre3kAxsy5syMlGGmv96vOvBSyS5c3hvY69H4JrCokimhv5GM8QnFHMQy+tr0Qzx3aL6z4to66LIRI/s1C0Pfpg0IP9gfChxEqmqymy8GV/TkqMF6ivQOP9I2l65HRAG6lMwBYMEI4HukIGE4ux37zGNskyZqKLB9E2hCUChqmELtUK1YwPJavWVhTb9itZcK+PJegrjAV+CRyVEuGVMYHQMgmhmTgqFIe1SibTECrNRlA/wJ1L/trVWrDVD/f+1Pkl1r6+0PTELhGFjo6hs5kAft6WkDpq7KiLEG0BvjODNX0XTuraUYRr3/kqToLWE8Smym1iA7c/nKYfopAY1clB6w3ALoQjckj1gUcwMiCAHrWUEGPLh9030jDsQQNjJUXG+gkGx+iMwviZwDPw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199015)(316002)(2906002)(4001150100001)(54906003)(6916009)(6512007)(186003)(41300700001)(83380400001)(7416002)(44832011)(33656002)(66574015)(122000001)(5660300002)(8936002)(2616005)(36756003)(38100700002)(66476007)(66446008)(64756008)(8676002)(4326008)(66556008)(91956017)(76116006)(66946007)(478600001)(86362001)(6486002)(53546011)(6506007)(66899015)(71200400001)(26005)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mk11S3JyYkVZbSthNXhwc0xRUjZhUExZVHlIODR1Y3d2K0o3ZHQ1MUFmT0xa?=
 =?utf-8?B?RFFWTjJ1cHZzRnZHc3pJU1dGSEJJS2hEbGo0L3pTMGZ1eEdYWmRMK0lZWGJ5?=
 =?utf-8?B?V1pZM2N1WkVHRVRUS1VsRUhWcFRhcDRiRFBCdFJGWlByVHI0UndzeVI1VGJy?=
 =?utf-8?B?ZkZMTm1BcGpwU1ViOURUcVB6ckdqUG02Yk5xdTZTdlBkMms2L2pnNzI3V1VF?=
 =?utf-8?B?TDR3VHVWNHlxOXdaelhxbWNCLzloM2VQNFM4cC94UGxZclZxQ3cxd05Ub09I?=
 =?utf-8?B?Q2RLbnZKSDdYWUhGdGFkYm5tV2ROTjh2cjd2S0ZzcFlTbWxxd05KL0ZtTE1S?=
 =?utf-8?B?QTlhSEFOSElpaS82eU5rcTZNYjRiblMxQ1hhcVl2N2pKOXNNTTRzcWxGM0p3?=
 =?utf-8?B?TzVucnNQODdxVEJ4VFFZdURXR3ZQbUhIRHlJVXltSnpEZ05YaGRUdjhmWmR3?=
 =?utf-8?B?dEtxamc4ZTRjNWZsdHNaMkc3WjVzRXVwNWhlS3BXY3ErUTQ3UXcxc2NTSlpr?=
 =?utf-8?B?UEdqcUc5SUJKb0hmR2dqWWwyTEZ6VEZYTmNnTEdBRXNTY1BmcG5Pc0JjbEhk?=
 =?utf-8?B?bHdXc3E1cFlGR2VMQkhTZmhXZFBTc1dBaVQ5OS9rN0lKN3M1b2cwbS9tUjgr?=
 =?utf-8?B?TStlaitDYzVwdFFiMXBpMWRMeVRpUWFqTUJLWG1lUGZDdlJqaTZHa0Fmaytu?=
 =?utf-8?B?SlVhVHB1dVAvKyt1dlczdGkvYkZJQUNLMjFaRmFycHUrN3dDRDdKandHVWQ4?=
 =?utf-8?B?Y2JHM1JBUTZ0cFVRL1lsVUJTSEdXM284R0RpdlZ1bTZVVTJ2aGRCZU1RKzBW?=
 =?utf-8?B?eXQyT0VEczFSdUx4d2cvSDJUaTVqQWF1QitsU0NpUE1RTys4VlMyL2l0Qzh6?=
 =?utf-8?B?aEZpbXRNMkdKZDBsTlZYRW83RmxQQ0dMMDhrZkdoRFcxSWEvWWlKdW1RUWhV?=
 =?utf-8?B?QlZMRm1SRDdnTnBMYUpFc083aGpEMWRPUURhcUVmWlBWRDZESmlZZ3dMYmZp?=
 =?utf-8?B?WG9qdEtLbXJGa01mMmlLOGNYTWdGdzJjc2x1WXB3bXV1L050TDFZb2grTjRF?=
 =?utf-8?B?OG1ubTdrbm9aR1J1SFJsSWxoZnJqdVNmaUoxMm5WVS9ScUFmTjIzcEIzRG80?=
 =?utf-8?B?R09MMVg3V2kvQlRBRUl4VmkrVlFITVNld09lM2NKTnZ5TnNwMzMyWGhOblNS?=
 =?utf-8?B?dFB6RVd4NHQ2ZmdpZXNjakpRWUZnNmY1N0ZVenlkSFpjb25VMjlFYm5TQ2xy?=
 =?utf-8?B?QlAzbEMvRmNmdVRXN1IwbjdZZERUSUhJaGFYdURVeDkwOFNMcUhQWHY2QUdT?=
 =?utf-8?B?Vm9FNmtlVW9Ddm1mYlBrVk1xSS9kU1dRT3ZnWHVvWkdkWkRHek9BbkZSZkNm?=
 =?utf-8?B?eFRRQk8rVjFXL2FaeWFGalFKcGNvTTgxVlNkS2p3RzYyTmVYQjd1eStRWkpn?=
 =?utf-8?B?cWZMdVVnOVpNTGtnZndSM29lcEJHbGsxTGRuMmxQanJjQ2NDblFEY3JPc2pV?=
 =?utf-8?B?VEVvb2tidE5BZjZhWGlnZzlIWlUzRzgrUXRyNko5MlJWaTF4c1AwcVFKUXo0?=
 =?utf-8?B?R1A0bS9vd2VHK3VpT2hUM3g4SG5DYXoxWEZERmdnc0l3VmN6cXFUWlhaMGh6?=
 =?utf-8?B?aXpYUHUyMExMM1ByaTU1SmFzS0FGVVRSMFlZaUdhQVVQanlmbzlQOWorWGxr?=
 =?utf-8?B?MU56YWgvS1MrbHNGZkxYMU4wT2t3dWlwSFJEVmJlSm1KRTY0WGxWNnkveEM0?=
 =?utf-8?B?dytuNFRuMHV5VUdLandZakpSSDhXblRMS3U2eU94OVVuTm9ZNE8vVXZjVDhQ?=
 =?utf-8?B?QjBrZW1Mb0hjWStLQ2dHUXFUME9HN3BKeTdCdGtoQXdjZ0M5L09MUXpBclMx?=
 =?utf-8?B?L3JJQWMxTEdZUWpFQVQwMkdqVXQxczZ1cUd2R01IbVlpTFZoSU1GUW1lcWJt?=
 =?utf-8?B?WGRSMEJPMjRZM0d6OWRjTTBnRnJWYi9CSzcyc1ZLdHVEbXhnRVJLbUplSklJ?=
 =?utf-8?B?R1BTT1Vjc1laTncvTXRIWXViVnJlTFBqR3lFTEp4aVphUG1XNXlINlZsa1cw?=
 =?utf-8?B?Wk4vZmgrRDJROEhONjdnUUszNlZORllSaE1LVllzQWVvRHBRSUNrUTdRQTJk?=
 =?utf-8?B?QmJ3RFBVbGYxYmNDU0FocDlUUE1yODhPcWcwNEpuaFkrYjdnNDJ6VjFwdXp6?=
 =?utf-8?B?QUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0B220AEC8241B4397DBF130876BDDBD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b482fe-2c7e-4858-3bf8-08dae42f68c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 15:15:49.8582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4lmqcwhizFJErfJAKi25nZu4fhULgPq04/7aDJnb1Ckx6oNNiQ70GIys7R1Y+clpE9Vsqd0J0n6cQU6XIeikt5r9BxgpfNEcTCz8gMQU9WA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_08,2022-12-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212220132
X-Proofpoint-GUID: 7WpxiFAa7HwqZv4Titq4qs2hR8DkXl5f
X-Proofpoint-ORIG-GUID: 7WpxiFAa7HwqZv4Titq4qs2hR8DkXl5f
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gT24gRGVjIDIxLCAyMDIyLCBhdCAxMjowMSBQTSwgTWltaSBab2hhciA8em9oYXJAbGlu
dXguaWJtLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIDIwMjItMTItMjEgYXQgMTg6MjcgKzAw
MDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+PiANCj4+PiBPbiBEZWMgMTgsIDIwMjIsIGF0IDU6
MjEgQU0sIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+
IE9uIEZyaSwgMjAyMi0xMi0xNiBhdCAyMjowNiArMDgwMCwgQ29pYnkgWHUgd3JvdGU6DQo+Pj4+
IEhpIEVyaWMgYW5kIE1pbWksDQo+Pj4+IA0KPj4+PiBPbiBUaHUsIERlYyAxNSwgMjAyMiBhdCAw
OTo0NTozN1BNICswMDAwLCBFcmljIFNub3diZXJnIHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiANCj4+
Pj4+Pj4+Pj4+IEEgQ0EgY2VydCBzaGFsbCBiZSBkZWZpbmVkIGFzIGFueSBYNTA5IGNlcnRpZmlj
YXRlIHRoYXQgY29udGFpbnMgdGhlDQo+Pj4+Pj4+Pj4+PiBrZXlDZXJ0U2lnbiBrZXkgdXNhZ2Ug
YW5kIGhhcyB0aGUgQ0EgYml0IHNldCB0byB0cnVlLg0KPj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4g
SGkgRXJpYywNCj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+IEFsbG93aW5nIENBIGNlcnRpZmljYXRl
cyB3aXRoIHRoZSBkaWdpdGFsU2lnbmF0dXJlIGtleSB1c2FnZSBmbGFnDQo+Pj4+Pj4+Pj4+IGVu
YWJsZWQgZGVmZWF0cyB0aGUgcHVycG9zZSBvZiB0aGUgbmV3IEtjb25maWcuICBQbGVhc2UgdXBk
YXRlIHRoZQ0KPj4+Pj4+Pj4+PiBhYm92ZSBkZWZpbml0aW9uIHRvIGV4Y2x1ZGUgdGhlIGRpZ2l0
YWxTaWduYXR1cmUga2V5IHVzYWdlIGZsYWcgYW5kDQo+Pj4+Pj4+Pj4+IG1vZGlmeSB0aGUgY29k
ZSBhY2NvcmRpbmdseS4NCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBXaXRoaW4gdjIsIHRoZSByZXF1
ZXN0IHdhcyBtYWRlIHRvIGFsbG93IEludGVybWVkaWF0ZSBDQSBjZXJ0aWZpY2F0ZXMgdG8gYmUN
Cj4+Pj4+Pj4+PiBsb2FkZWQgZGlyZWN0bHkuICBUaGUgSW50ZXJtZWRpYXRlIENBIHJlZmVyZW5j
ZWQgd2FzIHRoZSBvbmUgdXNlZCBieSBrZXJuZWwub3JnLg0KPj4+Pj4+Pj4+IFRoaXMgSW50ZXJt
ZWRpYXRlIENBIGNvbnRhaW5zIGJvdGggZGlnaXRhbFNpZ25hdHVyZSBhbmQga2V5Q2VydFNpZ24u
ICBJZiB0aGUgY29kZQ0KPj4+Pj4+Pj4+IGlzIGNoYW5nZWQgdG8gZXhjbHVkZSB0aGlzIGNlcnRp
ZmljYXRlLCBub3cgdGhlIHJvb3QgQ0EgaGFzIHRvIGJlIGxvYWRlZCBhZ2Fpbi4gIElzIHRoYXQN
Cj4+Pj4+Pj4+PiB0aGUgaW50ZW50Pw0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBUaGF0IGRlZmluaXRl
bHkgd2FzIG5vdCB0aGUgaW50ZW50LiAgTm9yIHdvdWxkIGl0IGFkZHJlc3MgdGhlIGlzc3VlIG9m
DQo+Pj4+Pj4+PiBhIHBhcnRpY3VsYXIgaW50ZXJtZWRpYXRlIENBIGNlcnRpZmljYXRlIGhhdmlu
ZyBib3RoIGtleUNlcnRTaWduIGFuZA0KPj4+Pj4+Pj4gZGlnaXRhbFNpZ25hdHVyZS4NCj4+Pj4+
Pj4gDQo+Pj4+Pj4+IFNvcnJ5LCBJ4oCZbSBub3QgZm9sbG93aW5nLiAgV2h5IGlzIGl0IGFuIGlz
c3VlIHRoYXQgYW4gaW50ZXJtZWRpYXRlIENBIGNlcnRpZmljYXRlIGNvbnRhaW5zDQo+Pj4+Pj4+
IGJvdGgga2V5Q2VydFNpZ24gYW5kIGRpZ2l0YWxTaWduYXR1cmU/IFdoeSB3b3VsZCB3ZSB3YW50
IHRvIGV4Y2x1ZGUgYW4gSW50ZXJtZWRpYXRlDQo+Pj4+Pj4+IENBIGNlcnQgbGlrZSB0aGUgb25l
IHVzZWQgb24ga2VybmVsLm9yZz8NCj4+Pj4+PiANCj4+Pj4+PiBJIG11c3QgYmUgbWlzc2luZyBz
b21ldGhpbmcuICBJc24ndCB0aGUgcHVycG9zZSBvZiAia2V5VXNhZ2UiIHRvDQo+Pj4+Pj4gbWlu
aW1pemUgaG93IGEgY2VydGlmaWNhdGUgbWF5IGJlIHVzZWQ/ICAgV2h5IHdvdWxkIHdlIHdhbnQg
dGhlIHNhbWUNCj4+Pj4+PiBjZXJ0aWZpY2F0ZSB0byBiZSB1c2VkIGZvciBib3RoIGNlcnRpZmlj
YXRlIHNpZ25pbmcgYW5kIGNvZGUgc2lnbmluZz8NCj4+Pj4+IA0KPj4+Pj4gRXZlcnkgM3JkIHBh
cnR5IGludGVybWVkaWF0ZSBDQSBJIGhhdmUgbG9va2VkIGF0IHNvIGZhciBjb250YWlucyBib3Ro
IHNldC4gTW9zdCBoYXZlIENSTFNpZ24gc2V0Lg0KPj4+Pj4gVHlwaWNhbGx5IHRoZSByb290IENB
IGNvbnRhaW5zIGtleUNlcnRTaWduIGFuZCBDUkxTaWduLCBidXQgc29tZSBhbHNvIGhhdmUgZGln
aXRhbFNpZ25hdHVyZQ0KPj4+Pj4gc2V0LiAgRmluZGluZyBhIDNyZCBwYXJ0eSBJbnRlcm1lZGlh
dGUgQ0Egd2l0aG91dCBkaWdpdGFsU2lnbmF0dXJlIHNldCBpcyBwcm9iYWJseSBnb2luZyB0byBi
ZQ0KPj4+Pj4gY2hhbGxlbmdpbmcgYW5kIHdpbGwgc2V2ZXJlbHkgbGltaXQgdXNhZ2UuDQo+Pj4+
IA0KPj4+PiBIb3cgYWJvdXQgYWxsb3dpbmcgYm90aCBrZXlDZXJ0U2lnbiBhbmQgZGlnaXRhbFNp
Z25hdHVyZSBhc3NlcnRlZCBidXQNCj4+Pj4gaXNzdWluZyBhIHdhcm5pbmcgZm9yIHRoaXMgY2Fz
ZT8NCj4+Pj4gDQo+Pj4+IEhlcmUncyBteSByYXRpb25hbGUgZm9yIHRoaXMgcHJvcG9zYWwuDQo+
Pj4+IA0KPj4+PiBJIGFzc3VtZSB3ZSBzaG91bGQgY29uZm9ybSB0byBzb21lIFguNTA5IHNwZWNp
ZmljYXRpb25zLiBTbyBJIGNoZWNrZWQNCj4+Pj4gIlJGQyA1MjgwOiBJbnRlcm5ldCBYLjUwOSBQ
dWJsaWMgS2V5IEluZnJhc3RydWN0dXJlIENlcnRpZmljYXRlIGFuZA0KPj4+PiBDZXJ0aWZpY2F0
ZSBSZXZvY2F0aW9uIExpc3QgKENSTCkgUHJvZmlsZSIgWzFdIGFuZCBJVFUtVCBYLjUwOSAoMjAx
Mi0xMCkNCj4+Pj4gWzJdLg0KPj4+PiANCj4+Pj4gWzFdIHN0YXRlcyBpbiA0LjIuMS4zLiBLZXkg
VXNhZ2UsDQo+Pj4+ICAgIklmIHRoZSBrZXlVc2FnZSBleHRlbnNpb24gaXMgcHJlc2VudCwgdGhl
biB0aGUgc3ViamVjdCBwdWJsaWMga2V5DQo+Pj4+ICAgTVVTVCBOT1QgYmUgdXNlZCB0byB2ZXJp
Znkgc2lnbmF0dXJlcyBvbiBjZXJ0aWZpY2F0ZXMgb3IgQ1JMcyB1bmxlc3MNCj4+Pj4gICB0aGUg
Y29ycmVzcG9uZGluZyBrZXlDZXJ0U2lnbiBvciBjUkxTaWduIGJpdCBpcyBzZXQuICBJZiB0aGUg
c3ViamVjdA0KPj4+PiAgIHB1YmxpYyBrZXkgaXMgb25seSB0byBiZSB1c2VkIGZvciB2ZXJpZnlp
bmcgc2lnbmF0dXJlcyBvbg0KPj4+PiAgIGNlcnRpZmljYXRlcyBhbmQvb3IgQ1JMcywgdGhlbiB0
aGUgZGlnaXRhbFNpZ25hdHVyZSBhbmQNCj4+Pj4gICBub25SZXB1ZGlhdGlvbiBiaXRzIFNIT1VM
RCBOT1QgYmUgc2V0LiAgSG93ZXZlciwgdGhlIGRpZ2l0YWxTaWduYXR1cmUNCj4+Pj4gICBhbmQv
b3Igbm9uUmVwdWRpYXRpb24gYml0cyBNQVkgYmUgc2V0IGluIGFkZGl0aW9uIHRvIHRoZSBrZXlD
ZXJ0U2lnbg0KPj4+PiAgIGFuZC9vciBjUkxTaWduIGJpdHMgaWYgdGhlIHN1YmplY3QgcHVibGlj
IGtleSBpcyB0byBiZSB1c2VkIHRvIHZlcmlmeQ0KPj4+PiAgIHNpZ25hdHVyZXMgb24gY2VydGlm
aWNhdGVzIGFuZC9vciBDUkxzIGFzIHdlbGwgYXMgb3RoZXIgb2JqZWN0cy4iDQo+Pj4+IA0KPj4+
PiBhbmQgWzJdIHN0YXRlcyBpbiA4LjIuMi4zIEtleSB1c2FnZSBleHRlbnNpb24gdGhhdCwNCj4+
Pj4gICJNb3JlIHRoYW4gb25lIGJpdCBtYXkgYmUgc2V0IGluIGFuIGluc3RhbmNlIG9mIHRoZSBr
ZXlVc2FnZSBleHRlbnNpb24uDQo+Pj4+ICBUaGUgc2V0dGluZyBvZiBtdWx0aXBsZSBiaXRzIHNo
YWxsIG5vdCBjaGFuZ2UgdGhlIG1lYW5pbmcgb2YgZWFjaA0KPj4+PiAgaW5kaXZpZHVhbCBiaXQg
YnV0IHNoYWxsIGluZGljYXRlIHRoYXQgdGhlIGNlcnRpZmljYXRlIG1heSBiZSB1c2VkIGZvcg0K
Pj4+PiAgYWxsIG9mIHRoZSBwdXJwb3NlcyBpbmRpY2F0ZWQgYnkgdGhlIHNldCBiaXRzLiBUaGVy
ZSBtYXkgYmUgcmlza3MNCj4+Pj4gIGluY3VycmVkIHdoZW4gc2V0dGluZyBtdWx0aXBsZSBiaXRz
LiBBIHJldmlldyBvZiB0aG9zZSByaXNrcyBpcw0KPj4+PiAgZG9jdW1lbnRlZCBpbiBBbm5leCBJ
LiINCj4+Pj4gDQo+Pj4+IEkgaW50ZXJwcmV0IHRoZSBhYm92ZSB0ZXh0cyBhcyB3ZSBzaG91bGQg
YWxsb3cgYm90aCBrZXlDZXJ0U2lnbiBhbmQNCj4+Pj4gZGlnaXRhbFNpZ25hdHVyZS4gSG93ZXZl
ciBbMl0gd2FybnMgYWJvdXQgdGhlIHJpc2tzIG9mIHNldHRpbmcgbXVsdGlwbGUNCj4+Pj4gYml0
cy4gUXVvdGluZyBBbm5leCBJLA0KPj4+PiANCj4+Pj4gICJDb21iaW5pbmcgdGhlIGNvbnRlbnRD
b21taXRtZW50IGJpdCBpbiB0aGUga2V5VXNhZ2UgY2VydGlmaWNhdGUNCj4+Pj4gIGV4dGVuc2lv
biB3aXRoIG90aGVyIGtleVVzYWdlIGJpdHMgbWF5IGhhdmUgc2VjdXJpdHkgaW1wbGljYXRpb25z
DQo+Pj4+ICBkZXBlbmRpbmcgb24gdGhlIHNlY3VyaXR5IGVudmlyb25tZW50IGluIHdoaWNoIHRo
ZSBjZXJ0aWZpY2F0ZSBpcyB0byBiZQ0KPj4+PiAgdXNlZC4gSWYgdGhlIHN1YmplY3QncyBlbnZp
cm9ubWVudCBjYW4gYmUgZnVsbHkgY29udHJvbGxlZCBhbmQgdHJ1c3RlZCwNCj4+Pj4gIHRoZW4g
dGhlcmUgYXJlIG5vIHNwZWNpZmljIHNlY3VyaXR5IGltcGxpY2F0aW9ucy4gRm9yIGV4YW1wbGUs
IGluIGNhc2VzDQo+Pj4+ICB3aGVyZSB0aGUgc3ViamVjdCBpcyBmdWxseSBjb25maWRlbnQgYWJv
dXQgZXhhY3RseSB3aGljaCBkYXRhIGlzIHNpZ25lZA0KPj4+PiAgb3IgY2FzZXMgd2hlcmUgdGhl
IHN1YmplY3QgaXMgZnVsbHkgY29uZmlkZW50IGFib3V0IHRoZSBzZWN1cml0eQ0KPj4+PiAgY2hh
cmFjdGVyaXN0aWNzIG9mIHRoZSBhdXRoZW50aWNhdGlvbiBwcm90b2NvbCBiZWluZyB1c2VkLiBJ
ZiB0aGUNCj4+Pj4gIHN1YmplY3QncyBlbnZpcm9ubWVudCBpcyBub3QgZnVsbHkgY29udHJvbGxl
ZCBvciBub3QgZnVsbHkgdHJ1c3RlZCwgdGhlbg0KPj4+PiAgdW5pbnRlbnRpb25hbCBzaWduaW5n
IG9mIGNvbW1pdG1lbnRzIGlzIHBvc3NpYmxlLiBFeGFtcGxlcyBpbmNsdWRlIHRoZQ0KPj4+PiAg
dXNlIG9mIGJhZGx5IGZvcm1lZCBhdXRoZW50aWNhdGlvbiBleGNoYW5nZXMgYW5kIHRoZSB1c2Ug
b2YgYSByb2d1ZQ0KPj4+PiAgc29mdHdhcmUgY29tcG9uZW50LiBJZiB1bnRydXN0ZWQgZW52aXJv
bm1lbnRzIGFyZSB1c2VkIGJ5IGEgc3ViamVjdCwNCj4+Pj4gIHRoZXNlIHNlY3VyaXR5IGltcGxp
Y2F0aW9ucyBjYW4gYmUgbGltaXRlZCB0aHJvdWdoIHVzZSBvZiB0aGUgZm9sbG93aW5nDQo+Pj4+
ICBtZWFzdXJlczogICANCj4+Pj4gICDigJMgdG8gbm90IGNvbWJpbmUgdGhlIGNvbnRlbnRDb21t
aXRtZW50IGtleSB1c2FnZSBzZXR0aW5nIGluDQo+Pj4+ICAgICBjZXJ0aWZpY2F0ZXMgd2l0aCBh
bnkgb3RoZXIga2V5IHVzYWdlIHNldHRpbmcgYW5kIHRvIHVzZSB0aGUNCj4+Pj4gICAgIGNvcnJl
c3BvbmRpbmcgcHJpdmF0ZSBrZXkgb25seSB3aXRoIHRoaXMgY2VydGlmaWNhdGU7ICAgDQo+Pj4+
IA0KPj4+PiAgIOKAkyB0byBsaW1pdCB0aGUgdXNlIG9mIHByaXZhdGUga2V5cyBhc3NvY2lhdGVk
IHdpdGggY2VydGlmaWNhdGVzIHRoYXQNCj4+Pj4gICAgIGhhdmUgdGhlIGNvbnRlbnRDb21taXRt
ZW50IGtleSB1c2FnZSBiaXQgc2V0LCB0byBlbnZpcm9ubWVudHMgd2hpY2gNCj4+Pj4gICAgIGFy
ZSBjb25zaWRlcmVkIGFkZXF1YXRlbHkgY29udHJvbGxlZCBhbmQgdHJ1c3R3b3J0aHkiDQo+Pj4+
IA0KPj4+PiBTbyBtYXliZSBpdCdzIHVzZWZ1bCB0byBhZGQgYSB3YXJuaW5nIGlmIGJvdGgga2V5
Q2VydFNpZ24gYW5kDQo+Pj4+IGRpZ2l0YWxTaWduYXR1cmUgYXJlIGFzc2VydGVkLg0KPj4+IA0K
Pj4+IENvaWJ5LCB0aGFuayB5b3UgZm9yIGFkZGluZyB0aGVzZSBkZXRhaWxzLiAgSSB3YXMgaG9w
aW5nIG90aGVycyB3b3VsZA0KPj4+IGNoaW1lIGluIGFzIHdlbGwuICBJIGFncmVlIGF0IG1pbmlt
dW0gdGhlcmUgc2hvdWxkIGJlIGEgd2FybmluZy4NCj4+IA0KPj4gQSB3YXJuaW5nIGNvdWxkIGJl
IGFkZGVkLg0KPj4gDQo+Pj4gUGVyaGFwcyBpbnN0ZWFkIG9mIG1ha2luZyBJTlRFR1JJVFlfQ0Ff
TUFDSElORV9LRVlSSU5HIGRlcGVuZGVudCBvbg0KPj4+IElOVEVHUklUWV9NQUNISU5FX0tFWVJJ
TkcsIG1ha2UgdGhlbSBhIEtjb25maWcgImNob2ljZSIgdG8gc3VwcG9ydCB0aGUNCj4+PiBtb3Jl
IHJlc3RyaWN0aXZlIGNlcnRpZmljYXRlIHVzZSBjYXNlIHJlcXVpcmVtZW50czogIGFsbCBjZXJ0
aWZpY2F0ZXMsDQo+Pj4gQ0EgY2VydGlmaWNhdGUgc2lnbmluZyBhbmQgZGlnaXRhbCBzaWduYXR1
cmUsIG9ubHkgQ0EgY2VydGlmaWNhdGUNCj4+PiBzaWduaW5nLg0KPj4gDQo+PiBBcyBjb3VsZCBz
dXBwb3J0IGZvciBhZGRpdGlvbmFsIHJlc3RyaWN0aW9ucy4NCj4+IA0KPj4gV291bGQgdGhlc2Ug
YWRkaXRpb25zIGJlIHJlcXVpcmVkIHdpdGhpbiB0aGlzIHNlcmllcz8gV2hhdCBpcyBtaXNzaW5n
IGZyb20gdGhpcyANCj4+IGRpc2N1c3Npb24gaXMgd2h5IHdvdWxkIHRoZXNlIGFkZGl0aW9ucyBi
ZSBuZWNlc3Nhcnk/ICBXaHkgc2hvdWxkIHRoZSBrZXJuZWwgDQo+PiBlbmZvcmNlIGEgcmVzdHJp
Y3Rpb24gdGhhdCBpcyBiZXlvbmQgdGhlIHNjb3BlIG9mIHRoZSBYLjUwOSBzcGVjPyAgSWYgYSB3
YXJuaW5nIHdhcyANCj4+IHRvIGJlIGFkZGVkLCB3aGF0IHdvdWxkIGJlIHRoZSBqdXN0aWZpY2F0
aW9uIGZvciBhZGRpbmcgdGhpcyBhZGRpdGlvbmFsIGNvZGU/ICBGcm9tIA0KPj4gbXkgcmVzZWFy
Y2ggZXZlcnkgc2luZ2xlIDNyZCBwYXJ0eSBjb2RlIHNpZ25pbmcgaW50ZXJtZWRpYXRlIENBIHdv
dWxkIGJlIGZsYWdnZWQgDQo+PiB3aXRoIHRoZSB3YXJuaW5nLiAgSXNu4oCZdCB0aGlzIGp1c3Qg
Z29pbmcgdG8gY2F1c2UgY29uZnVzaW9uPyAgT3IgaXMgdGhlcmUgYSBiZW5lZml0IHRoYXQgDQo+
PiBJIGFtIG1pc3NpbmcgdGhhdCBuZWVkcyB0byBiZSBzdGF0ZWQ/DQo+IA0KPiBZb3UncmUgZm9j
dXNpbmcgb24gdGhpcmQgcGFydHkga2VybmVsIG1vZHVsZXMgYW5kIGZvcmdldHRpbmcgYWJvdXQg
dGhlDQo+IHNpbXBsZSB1c2UgY2FzZSBvZiBhbGxvd2luZyBhbiBlbmQgdXNlciAob3IgYnVzaW5l
c3MpIHRvIHNpZ24gdGhlaXIgb3duDQo+IGNvZGUuICBUcnVlIHRoZXkgY291bGQgdXNlIHRoZSBs
ZXNzIHJlc3RyaWN0aXZlIENBIGNlcnRpZmljYXRlcywgYnV0IGl0DQo+IGlzIHVubmVjZXNzYXJ5
Lg0KDQpNeSBmb2N1cyBpcyBvbiBzaWduaW5nIHVzZXItc3BhY2UgYXBwbGljYXRpb25zLCBhcyBv
dXRsaW5lZCBpbiB0aGUgY292ZXIgbGV0dGVyLiAgVGhpcyANCnNlcmllcyBoYXMgbm90aGluZyB0
byBkbyB3aXRoIGtlcm5lbCBtb2R1bGVzLiAgTW9zdCBlbmQtdXNlcnMgYW5kIGJ1c2luZXNzZXMg
cmVseSBvbiANCmEgdGhpcmQgcGFydHkgdG8gZGVhbCB3aXRoIGNvZGUgc2lnbmluZy4gIEFsbCB0
aGlyZCBwYXJ0eSBjb2RlIHNpZ25pbmcgc2VydmljZXMgSSBoYXZlIA0KZm91bmQgdXNlIGFuIGlu
dGVybWVkaWF0ZSBDQSBjb250YWluaW5nIG1vcmUgdGhhbiBqdXN0IHRoZSBrZXlDZXJ0U2lnbiB1
c2FnZSBzZXQuICANCkl0IHNlZW1zIHRvIGJlIGFuIGluZHVzdHJ5IGFjY2VwdGVkIHByYWN0aWNl
IHRoYXQgZG9lcyBub3QgdmlvbGF0ZSB0aGUgc3BlYy4gQmVmb3JlIHdyaXRpbmcNCm5ldyBjb2Rl
IHRvIGVpdGhlciB3YXJuIG9yIGV4Y2x1ZGUgYSB0aGlyZCBwYXJ0eSBpbnRlcm1lZGlhdGUgQ0Es
ICBJIHdvdWxkIGxpa2UgdG8gdW5kZXJzdGFuZCANCnRoZSBtb3RpdmF0aW9uIGJlaGluZCB0aGlz
IHJlcXVlc3QuDQoNCg==
