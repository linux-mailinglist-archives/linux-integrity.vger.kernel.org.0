Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8634A655295
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Dec 2022 17:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiLWQOm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Dec 2022 11:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiLWQOk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Dec 2022 11:14:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFFAA45D;
        Fri, 23 Dec 2022 08:14:37 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BNEEE1H012283;
        Fri, 23 Dec 2022 16:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=s9GW9bjEVV2bRrCseppnxYGmaSBkXadz4X5Ma6PZ894=;
 b=zQ84lZna6Q6+PrGLjceXczDNLV2FZS041vJlxyRj09ekLSUskrZ3usmSEWg+W5HX6OBB
 IzgR3MAyf6l5k63XFqSx8UTzW/Fgnt3yrCSm1HL8htO4Sdphs0ZHw827BFZdD+AVWmpP
 wefhMW3bAsAuycQEQLscJuDZP0t5ygsM5q3Q4Z47ecQz6zKkDp2c7k5Rd0ED2KPhYXBx
 iMzjBY/aMOdfTiO8f2ym1oHPScZ4XTzH0IUrmgczdye8iA2Lz71WpmsvVn8J7PKFuoeQ
 uUhcz/dsBV8LbckqdsGo2WZ4ZJuYORyZWtSZTBSBlPAj6p+wdob2WewHFbG9cOiD5zGE Bg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tnpeh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Dec 2022 16:13:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BNFBbNI037698;
        Fri, 23 Dec 2022 16:13:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mh479mqy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Dec 2022 16:13:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9LNfjANq5Yk2Oy3np+oOzzUQbCpynUghF9HEUr1Yr8FhpeuedqrcDCV4P66VhDKrVryqJdB4FQjLPB5IYodEaYOFDqK486axAN+8iHYJ7wguWaX4IggSYicGTNlZmKVGo7Md0SjLN+FFDhD5EliHkzK6YVoMc1zcbb5Z6XkuIoR47+YPCtReke/mggeuu+4XPj8TsTHTSA0QuJ05r0iEl37eteYXqIsET2fIpU7lxtqAEYZM+cvgKxO6zdBfmiEpDKoYqjPHNMbzlkLqaU7G8Fe+gMwCq366TT0p4brdbxqTD/ay/nuNnXRcS0HE6PjaV+T4DxVvEb8AP5bi3LD0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9GW9bjEVV2bRrCseppnxYGmaSBkXadz4X5Ma6PZ894=;
 b=d8a9kL0QBluXnlBbu14QOa8ypq5LR0FkVEcqbb2cqLP7+YXrk8+WzN3qCCiEcB5c7QbUlkHjuMLCfpTbHdUT5uKVWA8IJYgwOcBNdE1nm8bntAFNtkoH0PmoVgGqMiOogb/48//og5xevDMlIBAo5gNpvKL44MWjEc1Gcov4DYCsSWXgpV83yUZc9/0RfXYQI9UZnulyq8aBU+dHlmIHDYBWNG/CCUebMFkV/U0+nbPVB0JttztDbKzPThpis9bwDQky3RN07lKpCOD/713lY7TM+W5wImdI4MPiuewvxQvV7aruWCkADOFUxpWbJb3gI+eHHrzBAvn+g8A9729C5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9GW9bjEVV2bRrCseppnxYGmaSBkXadz4X5Ma6PZ894=;
 b=zyPMM+/y6DXF7pJVPM4waWpBOH1Mm9SyMi4hF+ZWkEpJGFOFdz5fr7AMksJmPtgv61gPLyQ/F7CByDZQF6udo/IyG+WnN1qCpS+GSwlB84KZuDsVE+uPnlOl+hNI22u7X5hpvA1f3BJkjfhRihk7SemNMUOXSYnqoYyTrA39Yq4=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5180.namprd10.prod.outlook.com (2603:10b6:610:db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Fri, 23 Dec
 2022 16:13:50 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%5]) with mapi id 15.20.5944.013; Fri, 23 Dec 2022
 16:13:50 +0000
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
Thread-Index: AQHZD1PCFegbrli1zUCp/3TmJTzIr65uvzMAgABmOoCAADsnAIAACGGAgAAJu4CAAAvJAIABEiUAgAMHQoCABR0rgIAACaUAgAFTMgCAAAcpgIABm1+A
Date:   Fri, 23 Dec 2022 16:13:49 +0000
Message-ID: <D1BF8D7B-F9E4-4C87-9288-534F3AE38ECF@oracle.com>
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
 <6AAEC343-E581-4355-ABD8-FE32A1BD16D8@oracle.com>
 <4ac6b5bd1b57bfc0c548e5711e46b341fd5cfe39.camel@linux.ibm.com>
In-Reply-To: <4ac6b5bd1b57bfc0c548e5711e46b341fd5cfe39.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|CH0PR10MB5180:EE_
x-ms-office365-filtering-correlation-id: c72cfe95-4835-44e8-8301-08dae500ad7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fr1O97jNKxC9plOcQGQxJqDcA27P7LLfbdhyCUIdflxNXmxh4eVrKuEwi0oVQ7de+rmihdYreYD3gEYEQZB/JHRCQpBVUAIrzA+YZeFdfFdC8IcIGjuUPZx9najadxkc5nebVkNy/3Qa6GHvB8x3aObRBy2w9ijWTuAVZQ6NAK5H2j61PJuvO6yi9t0KsHFrTAD6IKExYjUAqJuKDl6zOnbPV953XwR9wslu1bZW0m+MoJcVCnNdVLmOoNRNqIDTNy2SC8OsLUmXHMEcIkTfqRZLdIGrUWN9xo5JEX26pZMw/vTHAFV4tjR1tRUixLCkE7gL5aGdxY80b8aEPLGaZ+r+d/qKX18tebVXWxYoVQlSx/kjDlXp1VfYgqQQZDrJIfg38YCs/Dxx9iX3L89l3oidE5QfK80uLpNXQsKDXgRCNzWaULE/h3bkO6O+4CtuYqtzAkgT++lrygSIaO6C+8TsU53qOjnYHEVD/Kyi2ZEyICFhVbKl9iZNPVUKfz99/G+TIgCftfuQgjUpy0qFCFLvxr9dL28jT0S75ik/6X38gHEOaN3LSU0AavrDktOiiSyoGKFAC9u9t63g1ZKgmqtw6Wy+0Uus0DtIuoaDllgQssEeyMV3wWs+afK0LE9MBBjKEinAlW6kQq3m3+5TQuV8D0pxai7ywP5o9lYjprpvpK/t72rGNHqZNrchNvIX7jWejFZkIdKLKMMRiTvaor2v6qurCG8fvgb3p65Q3GQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199015)(6506007)(66899015)(86362001)(478600001)(53546011)(6486002)(38070700005)(71200400001)(41300700001)(186003)(83380400001)(7416002)(4001150100001)(316002)(2906002)(6512007)(54906003)(6916009)(36756003)(66476007)(2616005)(64756008)(66446008)(8676002)(91956017)(66946007)(76116006)(66556008)(4326008)(66574015)(38100700002)(33656002)(44832011)(8936002)(122000001)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHdTWnh3dVZKWnhIM0QvaW1SSXhtRG04U0I5RS9zejlMWGR0bkJiSVRmcTNa?=
 =?utf-8?B?anN4U1dicVBHb2NRU2hjdzVuUk0weFRQMHBDVXhSY1Vza1RMZGNLMVIyVHVj?=
 =?utf-8?B?Z3ZDY1o0WWlqbEhZbG5vWXRZd2ZzWHl2RDQyQlpqV3YxUkpmbGlZdmJkWTcy?=
 =?utf-8?B?RERaZlJzVys4WDRKMjVSVXNXNjFHbG9OQ2wrYUE0RkRtazJaTXBPdHlUR0pV?=
 =?utf-8?B?M0psaVJHZy9QVTVnTlByRkxpL1lySElnT01kQlJqTk8rdzNTTTYrbW9HWWNV?=
 =?utf-8?B?RXYzbzlLKzk3VzVYd1lGWVV6WFpNeDBDVzB5eTdwYnVKaktSbzVtWHZ5dE51?=
 =?utf-8?B?bzNlUzRnRVlEbUx6MEVlS3R4dW5Yb0IzM3VsVW8rQlRZVEsrTDdVdVFKc0hJ?=
 =?utf-8?B?dzdCbTJHaWVKeE82L3p3a1lJeWFxMWh0MERhU3FFYnh1dHpmcjdLanRsSmZt?=
 =?utf-8?B?bzUwalRxWkNPSUp1elZPcGs5RzJ3bDVMV0lZOEVFNk1yd2N5Mml1MUpSam1k?=
 =?utf-8?B?N1ZXT0VSbkRhM1dTTmcwbS95bGFxL1dlV04wM3psVDhucXdTaDE2MGhqTGtI?=
 =?utf-8?B?dXY4L3Jld0U3dEk5YitSdE8yL0dRYjNHY3JKVUhjQ1FzM2FobVBudjUrZHRC?=
 =?utf-8?B?bVJYVEpGRk8wTVJzb056cW9Vb3RVckVzOTVDUG1DR3FQZkw5bVNpZk1sTHM0?=
 =?utf-8?B?UE1mSUlreExWQzkvVU9tMThEb240dVBMOHh1QTUwdWt2b3d4RmQvdmd4ak0y?=
 =?utf-8?B?d253bEY3dTA5ZXdJMGhKdFhSc3phKyt0blBCOVpLR1JiNEhKQnpNS1JhMm9w?=
 =?utf-8?B?aUdSVWt2NUhIMWoxejJHMlQ2K1NnR3Y3c1BpTGFBZWxaRTZ2WjVJcDA4V2hQ?=
 =?utf-8?B?TkllbzdUWUNBRXkyNGQrN1psd1BZMEw0ZGdEcnRIMWZsK2JVQkdGOTdndk9L?=
 =?utf-8?B?V0FHbUhadUNRaHoyNWxxUitCVHNvUkFhN09DVHgxZW1SODdydVJudzZUaHVI?=
 =?utf-8?B?T1ZVWitwS1RxSUc1U3U2YXVkMmRoZ20zN0dlbDV3cEtQRlRSZ1ZXb0FDWi8y?=
 =?utf-8?B?Y1ZVTlJ6Ymplc1htVFpabGlQeHlTeTZlcWd0aFdtbnZycDdsUmRRSU51d3BQ?=
 =?utf-8?B?MmNDd0J0OVpHdmxtOXJkRjhnUFNKVExPb2o1KzczUVFpK3poejArY2U2TWxM?=
 =?utf-8?B?ZzkxZGkwY3BpbDJkcXhmUHFBVlEzZWJSdmE3bzA5MjdsSmlsY3poQzVaaU9C?=
 =?utf-8?B?TDF4c015Q2NvOCtDNis0SUEyclMybWI4aG9EeFdmMlZ5UXRLbGVxL0g4aVVV?=
 =?utf-8?B?N3ZWSzFCUkJwQkJjZ1JEL3BGVGI0dzdXQjJYcHBUNjRrbEwwVWJtNk1yaXZl?=
 =?utf-8?B?K1lUOFdiQ2FTSHZ0V3I5bXhUUllnOTU2TTdIR282bUVGYno1b1oxeFhrVGtC?=
 =?utf-8?B?UkVyelRWOVVEYWh0allQYjA3bm5iRlBNU3R5aU52bDZoeHppV2Q3WkUzUVBm?=
 =?utf-8?B?R0plZzBZeUJuZDU0cVY1d2QwN1JtYSs2aXhMUWc5eEtodjYvVXZvRmNpUVgz?=
 =?utf-8?B?V1g3NDROTHBYZzZnSHN5UzZqQXVlMlZBcmcrWUNLazJSVkhLN0UwNUxXbzBY?=
 =?utf-8?B?bXB1UVRib3RyUkpCTGlzcUVjalNnT0NycWlaM3p6MElic0RES0cvYjd4WTV5?=
 =?utf-8?B?b0wxczB3cEUzb1pOVlVDREpMTDNkM3plcFBkSEN3d2lNTFBoTzhKQzNqTTlt?=
 =?utf-8?B?VU1wWkwxbXVDaG9NRTA3SGNuN0xmRy9yZTN1WldnUjUvZzlNcit3OGpCT3cv?=
 =?utf-8?B?SFRJbjU4VGtlWjdVVW11YkRRLzVnbUU5T0F1Y3Bkb1JwVHZXZmZmOCtscktJ?=
 =?utf-8?B?VUcrZTd5UlRvNFFpZUtmN0gyMDBvbG43Z3ZFYlBXRDJYa0lOODVTVUQ5ZFVH?=
 =?utf-8?B?S3Q0a2cwNzNnVE9yQ0FFQ0VZN20yd0p2QUlWa1JRSHB0ZGhJa29YUVpMSE5x?=
 =?utf-8?B?c3BsOVNCL0JxdmhIWVFCSytiemdFSEpkdUptSzVQV28xLzR2Y3lGVTczazZ5?=
 =?utf-8?B?Y29teWdOZTNXQzlUMEg2aHRuRWJyTjYzSmlRYW9kamV1RnRtMlJnSzM5OHhS?=
 =?utf-8?B?TkdoWUM2eWZCNUJSMUJBbWl4OU5kd2JTQUdGRkg5dU8yd3JNRTNnSEtRYXZN?=
 =?utf-8?Q?vxmdLdDzVy4PtciM1bTrpqI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1BCE97DC292496479EA9D770A698303B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c72cfe95-4835-44e8-8301-08dae500ad7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2022 16:13:49.9191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hg/8mh5W2oWZGIyxCvYOtiRa4ys6foITqNeVxcuf9yNAgJ3LMeoedH/rlKzDE9ucX9wFvEZ5hVp4PNVxhxxyDcDnneWkoc32dexC49I0dRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-23_06,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212230135
X-Proofpoint-ORIG-GUID: luK5CRHTKkQ4WrAerYDRSbdx8mg_kGJk
X-Proofpoint-GUID: luK5CRHTKkQ4WrAerYDRSbdx8mg_kGJk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gT24gRGVjIDIyLCAyMDIyLCBhdCA4OjQxIEFNLCBNaW1pIFpvaGFyIDx6b2hhckBsaW51
eC5pYm0uY29tPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgMjAyMi0xMi0yMiBhdCAxNToxNSArMDAw
MCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+IA0KPj4+IE9uIERlYyAyMSwgMjAyMiwgYXQgMTI6
MDEgUE0sIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+
IE9uIFdlZCwgMjAyMi0xMi0yMSBhdCAxODoyNyArMDAwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToN
Cj4+Pj4gDQo+Pj4+PiBPbiBEZWMgMTgsIDIwMjIsIGF0IDU6MjEgQU0sIE1pbWkgWm9oYXIgPHpv
aGFyQGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBPbiBGcmksIDIwMjItMTIt
MTYgYXQgMjI6MDYgKzA4MDAsIENvaWJ5IFh1IHdyb3RlOg0KPj4+Pj4+IEhpIEVyaWMgYW5kIE1p
bWksDQo+Pj4+Pj4gDQo+Pj4+Pj4gT24gVGh1LCBEZWMgMTUsIDIwMjIgYXQgMDk6NDU6MzdQTSAr
MDAwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IA0KPj4+Pj4+Pj4+
Pj4+PiBBIENBIGNlcnQgc2hhbGwgYmUgZGVmaW5lZCBhcyBhbnkgWDUwOSBjZXJ0aWZpY2F0ZSB0
aGF0IGNvbnRhaW5zIHRoZQ0KPj4+Pj4+Pj4+Pj4+PiBrZXlDZXJ0U2lnbiBrZXkgdXNhZ2UgYW5k
IGhhcyB0aGUgQ0EgYml0IHNldCB0byB0cnVlLg0KPj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4+
IEhpIEVyaWMsDQo+Pj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+Pj4gQWxsb3dpbmcgQ0EgY2VydGlm
aWNhdGVzIHdpdGggdGhlIGRpZ2l0YWxTaWduYXR1cmUga2V5IHVzYWdlIGZsYWcNCj4+Pj4+Pj4+
Pj4+PiBlbmFibGVkIGRlZmVhdHMgdGhlIHB1cnBvc2Ugb2YgdGhlIG5ldyBLY29uZmlnLiAgUGxl
YXNlIHVwZGF0ZSB0aGUNCj4+Pj4+Pj4+Pj4+PiBhYm92ZSBkZWZpbml0aW9uIHRvIGV4Y2x1ZGUg
dGhlIGRpZ2l0YWxTaWduYXR1cmUga2V5IHVzYWdlIGZsYWcgYW5kDQo+Pj4+Pj4+Pj4+Pj4gbW9k
aWZ5IHRoZSBjb2RlIGFjY29yZGluZ2x5Lg0KPj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+PiBXaXRo
aW4gdjIsIHRoZSByZXF1ZXN0IHdhcyBtYWRlIHRvIGFsbG93IEludGVybWVkaWF0ZSBDQSBjZXJ0
aWZpY2F0ZXMgdG8gYmUNCj4+Pj4+Pj4+Pj4+IGxvYWRlZCBkaXJlY3RseS4gIFRoZSBJbnRlcm1l
ZGlhdGUgQ0EgcmVmZXJlbmNlZCB3YXMgdGhlIG9uZSB1c2VkIGJ5IGtlcm5lbC5vcmcuDQo+Pj4+
Pj4+Pj4+PiBUaGlzIEludGVybWVkaWF0ZSBDQSBjb250YWlucyBib3RoIGRpZ2l0YWxTaWduYXR1
cmUgYW5kIGtleUNlcnRTaWduLiAgSWYgdGhlIGNvZGUNCj4+Pj4+Pj4+Pj4+IGlzIGNoYW5nZWQg
dG8gZXhjbHVkZSB0aGlzIGNlcnRpZmljYXRlLCBub3cgdGhlIHJvb3QgQ0EgaGFzIHRvIGJlIGxv
YWRlZCBhZ2Fpbi4gIElzIHRoYXQNCj4+Pj4+Pj4+Pj4+IHRoZSBpbnRlbnQ/DQo+Pj4+Pj4+Pj4+
IA0KPj4+Pj4+Pj4+PiBUaGF0IGRlZmluaXRlbHkgd2FzIG5vdCB0aGUgaW50ZW50LiAgTm9yIHdv
dWxkIGl0IGFkZHJlc3MgdGhlIGlzc3VlIG9mDQo+Pj4+Pj4+Pj4+IGEgcGFydGljdWxhciBpbnRl
cm1lZGlhdGUgQ0EgY2VydGlmaWNhdGUgaGF2aW5nIGJvdGgga2V5Q2VydFNpZ24gYW5kDQo+Pj4+
Pj4+Pj4+IGRpZ2l0YWxTaWduYXR1cmUuDQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gU29ycnksIEni
gJltIG5vdCBmb2xsb3dpbmcuICBXaHkgaXMgaXQgYW4gaXNzdWUgdGhhdCBhbiBpbnRlcm1lZGlh
dGUgQ0EgY2VydGlmaWNhdGUgY29udGFpbnMNCj4+Pj4+Pj4+PiBib3RoIGtleUNlcnRTaWduIGFu
ZCBkaWdpdGFsU2lnbmF0dXJlPyBXaHkgd291bGQgd2Ugd2FudCB0byBleGNsdWRlIGFuIEludGVy
bWVkaWF0ZQ0KPj4+Pj4+Pj4+IENBIGNlcnQgbGlrZSB0aGUgb25lIHVzZWQgb24ga2VybmVsLm9y
Zz8NCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gSSBtdXN0IGJlIG1pc3Npbmcgc29tZXRoaW5nLiAgSXNu
J3QgdGhlIHB1cnBvc2Ugb2YgImtleVVzYWdlIiB0bw0KPj4+Pj4+Pj4gbWluaW1pemUgaG93IGEg
Y2VydGlmaWNhdGUgbWF5IGJlIHVzZWQ/ICAgV2h5IHdvdWxkIHdlIHdhbnQgdGhlIHNhbWUNCj4+
Pj4+Pj4+IGNlcnRpZmljYXRlIHRvIGJlIHVzZWQgZm9yIGJvdGggY2VydGlmaWNhdGUgc2lnbmlu
ZyBhbmQgY29kZSBzaWduaW5nPw0KPj4+Pj4+PiANCj4+Pj4+Pj4gRXZlcnkgM3JkIHBhcnR5IGlu
dGVybWVkaWF0ZSBDQSBJIGhhdmUgbG9va2VkIGF0IHNvIGZhciBjb250YWlucyBib3RoIHNldC4g
TW9zdCBoYXZlIENSTFNpZ24gc2V0Lg0KPj4+Pj4+PiBUeXBpY2FsbHkgdGhlIHJvb3QgQ0EgY29u
dGFpbnMga2V5Q2VydFNpZ24gYW5kIENSTFNpZ24sIGJ1dCBzb21lIGFsc28gaGF2ZSBkaWdpdGFs
U2lnbmF0dXJlDQo+Pj4+Pj4+IHNldC4gIEZpbmRpbmcgYSAzcmQgcGFydHkgSW50ZXJtZWRpYXRl
IENBIHdpdGhvdXQgZGlnaXRhbFNpZ25hdHVyZSBzZXQgaXMgcHJvYmFibHkgZ29pbmcgdG8gYmUN
Cj4+Pj4+Pj4gY2hhbGxlbmdpbmcgYW5kIHdpbGwgc2V2ZXJlbHkgbGltaXQgdXNhZ2UuDQo+Pj4+
Pj4gDQo+Pj4+Pj4gSG93IGFib3V0IGFsbG93aW5nIGJvdGgga2V5Q2VydFNpZ24gYW5kIGRpZ2l0
YWxTaWduYXR1cmUgYXNzZXJ0ZWQgYnV0DQo+Pj4+Pj4gaXNzdWluZyBhIHdhcm5pbmcgZm9yIHRo
aXMgY2FzZT8NCj4+Pj4+PiANCj4+Pj4+PiBIZXJlJ3MgbXkgcmF0aW9uYWxlIGZvciB0aGlzIHBy
b3Bvc2FsLg0KPj4+Pj4+IA0KPj4+Pj4+IEkgYXNzdW1lIHdlIHNob3VsZCBjb25mb3JtIHRvIHNv
bWUgWC41MDkgc3BlY2lmaWNhdGlvbnMuIFNvIEkgY2hlY2tlZA0KPj4+Pj4+ICJSRkMgNTI4MDog
SW50ZXJuZXQgWC41MDkgUHVibGljIEtleSBJbmZyYXN0cnVjdHVyZSBDZXJ0aWZpY2F0ZSBhbmQN
Cj4+Pj4+PiBDZXJ0aWZpY2F0ZSBSZXZvY2F0aW9uIExpc3QgKENSTCkgUHJvZmlsZSIgWzFdIGFu
ZCBJVFUtVCBYLjUwOSAoMjAxMi0xMCkNCj4+Pj4+PiBbMl0uDQo+Pj4+Pj4gDQo+Pj4+Pj4gWzFd
IHN0YXRlcyBpbiA0LjIuMS4zLiBLZXkgVXNhZ2UsDQo+Pj4+Pj4gICJJZiB0aGUga2V5VXNhZ2Ug
ZXh0ZW5zaW9uIGlzIHByZXNlbnQsIHRoZW4gdGhlIHN1YmplY3QgcHVibGljIGtleQ0KPj4+Pj4+
ICBNVVNUIE5PVCBiZSB1c2VkIHRvIHZlcmlmeSBzaWduYXR1cmVzIG9uIGNlcnRpZmljYXRlcyBv
ciBDUkxzIHVubGVzcw0KPj4+Pj4+ICB0aGUgY29ycmVzcG9uZGluZyBrZXlDZXJ0U2lnbiBvciBj
UkxTaWduIGJpdCBpcyBzZXQuICBJZiB0aGUgc3ViamVjdA0KPj4+Pj4+ICBwdWJsaWMga2V5IGlz
IG9ubHkgdG8gYmUgdXNlZCBmb3IgdmVyaWZ5aW5nIHNpZ25hdHVyZXMgb24NCj4+Pj4+PiAgY2Vy
dGlmaWNhdGVzIGFuZC9vciBDUkxzLCB0aGVuIHRoZSBkaWdpdGFsU2lnbmF0dXJlIGFuZA0KPj4+
Pj4+ICBub25SZXB1ZGlhdGlvbiBiaXRzIFNIT1VMRCBOT1QgYmUgc2V0LiAgSG93ZXZlciwgdGhl
IGRpZ2l0YWxTaWduYXR1cmUNCj4+Pj4+PiAgYW5kL29yIG5vblJlcHVkaWF0aW9uIGJpdHMgTUFZ
IGJlIHNldCBpbiBhZGRpdGlvbiB0byB0aGUga2V5Q2VydFNpZ24NCj4+Pj4+PiAgYW5kL29yIGNS
TFNpZ24gYml0cyBpZiB0aGUgc3ViamVjdCBwdWJsaWMga2V5IGlzIHRvIGJlIHVzZWQgdG8gdmVy
aWZ5DQo+Pj4+Pj4gIHNpZ25hdHVyZXMgb24gY2VydGlmaWNhdGVzIGFuZC9vciBDUkxzIGFzIHdl
bGwgYXMgb3RoZXIgb2JqZWN0cy4iDQo+Pj4+Pj4gDQo+Pj4+Pj4gYW5kIFsyXSBzdGF0ZXMgaW4g
OC4yLjIuMyBLZXkgdXNhZ2UgZXh0ZW5zaW9uIHRoYXQsDQo+Pj4+Pj4gIk1vcmUgdGhhbiBvbmUg
Yml0IG1heSBiZSBzZXQgaW4gYW4gaW5zdGFuY2Ugb2YgdGhlIGtleVVzYWdlIGV4dGVuc2lvbi4N
Cj4+Pj4+PiBUaGUgc2V0dGluZyBvZiBtdWx0aXBsZSBiaXRzIHNoYWxsIG5vdCBjaGFuZ2UgdGhl
IG1lYW5pbmcgb2YgZWFjaA0KPj4+Pj4+IGluZGl2aWR1YWwgYml0IGJ1dCBzaGFsbCBpbmRpY2F0
ZSB0aGF0IHRoZSBjZXJ0aWZpY2F0ZSBtYXkgYmUgdXNlZCBmb3INCj4+Pj4+PiBhbGwgb2YgdGhl
IHB1cnBvc2VzIGluZGljYXRlZCBieSB0aGUgc2V0IGJpdHMuIFRoZXJlIG1heSBiZSByaXNrcw0K
Pj4+Pj4+IGluY3VycmVkIHdoZW4gc2V0dGluZyBtdWx0aXBsZSBiaXRzLiBBIHJldmlldyBvZiB0
aG9zZSByaXNrcyBpcw0KPj4+Pj4+IGRvY3VtZW50ZWQgaW4gQW5uZXggSS4iDQo+Pj4+Pj4gDQo+
Pj4+Pj4gSSBpbnRlcnByZXQgdGhlIGFib3ZlIHRleHRzIGFzIHdlIHNob3VsZCBhbGxvdyBib3Ro
IGtleUNlcnRTaWduIGFuZA0KPj4+Pj4+IGRpZ2l0YWxTaWduYXR1cmUuIEhvd2V2ZXIgWzJdIHdh
cm5zIGFib3V0IHRoZSByaXNrcyBvZiBzZXR0aW5nIG11bHRpcGxlDQo+Pj4+Pj4gYml0cy4gUXVv
dGluZyBBbm5leCBJLA0KPj4+Pj4+IA0KPj4+Pj4+ICJDb21iaW5pbmcgdGhlIGNvbnRlbnRDb21t
aXRtZW50IGJpdCBpbiB0aGUga2V5VXNhZ2UgY2VydGlmaWNhdGUNCj4+Pj4+PiBleHRlbnNpb24g
d2l0aCBvdGhlciBrZXlVc2FnZSBiaXRzIG1heSBoYXZlIHNlY3VyaXR5IGltcGxpY2F0aW9ucw0K
Pj4+Pj4+IGRlcGVuZGluZyBvbiB0aGUgc2VjdXJpdHkgZW52aXJvbm1lbnQgaW4gd2hpY2ggdGhl
IGNlcnRpZmljYXRlIGlzIHRvIGJlDQo+Pj4+Pj4gdXNlZC4gSWYgdGhlIHN1YmplY3QncyBlbnZp
cm9ubWVudCBjYW4gYmUgZnVsbHkgY29udHJvbGxlZCBhbmQgdHJ1c3RlZCwNCj4+Pj4+PiB0aGVu
IHRoZXJlIGFyZSBubyBzcGVjaWZpYyBzZWN1cml0eSBpbXBsaWNhdGlvbnMuIEZvciBleGFtcGxl
LCBpbiBjYXNlcw0KPj4+Pj4+IHdoZXJlIHRoZSBzdWJqZWN0IGlzIGZ1bGx5IGNvbmZpZGVudCBh
Ym91dCBleGFjdGx5IHdoaWNoIGRhdGEgaXMgc2lnbmVkDQo+Pj4+Pj4gb3IgY2FzZXMgd2hlcmUg
dGhlIHN1YmplY3QgaXMgZnVsbHkgY29uZmlkZW50IGFib3V0IHRoZSBzZWN1cml0eQ0KPj4+Pj4+
IGNoYXJhY3RlcmlzdGljcyBvZiB0aGUgYXV0aGVudGljYXRpb24gcHJvdG9jb2wgYmVpbmcgdXNl
ZC4gSWYgdGhlDQo+Pj4+Pj4gc3ViamVjdCdzIGVudmlyb25tZW50IGlzIG5vdCBmdWxseSBjb250
cm9sbGVkIG9yIG5vdCBmdWxseSB0cnVzdGVkLCB0aGVuDQo+Pj4+Pj4gdW5pbnRlbnRpb25hbCBz
aWduaW5nIG9mIGNvbW1pdG1lbnRzIGlzIHBvc3NpYmxlLiBFeGFtcGxlcyBpbmNsdWRlIHRoZQ0K
Pj4+Pj4+IHVzZSBvZiBiYWRseSBmb3JtZWQgYXV0aGVudGljYXRpb24gZXhjaGFuZ2VzIGFuZCB0
aGUgdXNlIG9mIGEgcm9ndWUNCj4+Pj4+PiBzb2Z0d2FyZSBjb21wb25lbnQuIElmIHVudHJ1c3Rl
ZCBlbnZpcm9ubWVudHMgYXJlIHVzZWQgYnkgYSBzdWJqZWN0LA0KPj4+Pj4+IHRoZXNlIHNlY3Vy
aXR5IGltcGxpY2F0aW9ucyBjYW4gYmUgbGltaXRlZCB0aHJvdWdoIHVzZSBvZiB0aGUgZm9sbG93
aW5nDQo+Pj4+Pj4gbWVhc3VyZXM6ICAgDQo+Pj4+Pj4gIOKAkyB0byBub3QgY29tYmluZSB0aGUg
Y29udGVudENvbW1pdG1lbnQga2V5IHVzYWdlIHNldHRpbmcgaW4NCj4+Pj4+PiAgICBjZXJ0aWZp
Y2F0ZXMgd2l0aCBhbnkgb3RoZXIga2V5IHVzYWdlIHNldHRpbmcgYW5kIHRvIHVzZSB0aGUNCj4+
Pj4+PiAgICBjb3JyZXNwb25kaW5nIHByaXZhdGUga2V5IG9ubHkgd2l0aCB0aGlzIGNlcnRpZmlj
YXRlOyAgIA0KPj4+Pj4+IA0KPj4+Pj4+ICDigJMgdG8gbGltaXQgdGhlIHVzZSBvZiBwcml2YXRl
IGtleXMgYXNzb2NpYXRlZCB3aXRoIGNlcnRpZmljYXRlcyB0aGF0DQo+Pj4+Pj4gICAgaGF2ZSB0
aGUgY29udGVudENvbW1pdG1lbnQga2V5IHVzYWdlIGJpdCBzZXQsIHRvIGVudmlyb25tZW50cyB3
aGljaA0KPj4+Pj4+ICAgIGFyZSBjb25zaWRlcmVkIGFkZXF1YXRlbHkgY29udHJvbGxlZCBhbmQg
dHJ1c3R3b3J0aHkiDQo+Pj4+Pj4gDQo+Pj4+Pj4gU28gbWF5YmUgaXQncyB1c2VmdWwgdG8gYWRk
IGEgd2FybmluZyBpZiBib3RoIGtleUNlcnRTaWduIGFuZA0KPj4+Pj4+IGRpZ2l0YWxTaWduYXR1
cmUgYXJlIGFzc2VydGVkLg0KPj4+Pj4gDQo+Pj4+PiBDb2lieSwgdGhhbmsgeW91IGZvciBhZGRp
bmcgdGhlc2UgZGV0YWlscy4gIEkgd2FzIGhvcGluZyBvdGhlcnMgd291bGQNCj4+Pj4+IGNoaW1l
IGluIGFzIHdlbGwuICBJIGFncmVlIGF0IG1pbmltdW0gdGhlcmUgc2hvdWxkIGJlIGEgd2Fybmlu
Zy4NCj4+Pj4gDQo+Pj4+IEEgd2FybmluZyBjb3VsZCBiZSBhZGRlZC4NCj4+Pj4gDQo+Pj4+PiBQ
ZXJoYXBzIGluc3RlYWQgb2YgbWFraW5nIElOVEVHUklUWV9DQV9NQUNISU5FX0tFWVJJTkcgZGVw
ZW5kZW50IG9uDQo+Pj4+PiBJTlRFR1JJVFlfTUFDSElORV9LRVlSSU5HLCBtYWtlIHRoZW0gYSBL
Y29uZmlnICJjaG9pY2UiIHRvIHN1cHBvcnQgdGhlDQo+Pj4+PiBtb3JlIHJlc3RyaWN0aXZlIGNl
cnRpZmljYXRlIHVzZSBjYXNlIHJlcXVpcmVtZW50czogIGFsbCBjZXJ0aWZpY2F0ZXMsDQo+Pj4+
PiBDQSBjZXJ0aWZpY2F0ZSBzaWduaW5nIGFuZCBkaWdpdGFsIHNpZ25hdHVyZSwgb25seSBDQSBj
ZXJ0aWZpY2F0ZQ0KPj4+Pj4gc2lnbmluZy4NCj4+Pj4gDQo+Pj4+IEFzIGNvdWxkIHN1cHBvcnQg
Zm9yIGFkZGl0aW9uYWwgcmVzdHJpY3Rpb25zLg0KPj4+PiANCj4+Pj4gV291bGQgdGhlc2UgYWRk
aXRpb25zIGJlIHJlcXVpcmVkIHdpdGhpbiB0aGlzIHNlcmllcz8gV2hhdCBpcyBtaXNzaW5nIGZy
b20gdGhpcyANCj4+Pj4gZGlzY3Vzc2lvbiBpcyB3aHkgd291bGQgdGhlc2UgYWRkaXRpb25zIGJl
IG5lY2Vzc2FyeT8gIFdoeSBzaG91bGQgdGhlIGtlcm5lbCANCj4+Pj4gZW5mb3JjZSBhIHJlc3Ry
aWN0aW9uIHRoYXQgaXMgYmV5b25kIHRoZSBzY29wZSBvZiB0aGUgWC41MDkgc3BlYz8gIElmIGEg
d2FybmluZyB3YXMgDQo+Pj4+IHRvIGJlIGFkZGVkLCB3aGF0IHdvdWxkIGJlIHRoZSBqdXN0aWZp
Y2F0aW9uIGZvciBhZGRpbmcgdGhpcyBhZGRpdGlvbmFsIGNvZGU/ICBGcm9tIA0KPj4+PiBteSBy
ZXNlYXJjaCBldmVyeSBzaW5nbGUgM3JkIHBhcnR5IGNvZGUgc2lnbmluZyBpbnRlcm1lZGlhdGUg
Q0Egd291bGQgYmUgZmxhZ2dlZCANCj4+Pj4gd2l0aCB0aGUgd2FybmluZy4gIElzbuKAmXQgdGhp
cyBqdXN0IGdvaW5nIHRvIGNhdXNlIGNvbmZ1c2lvbj8gIE9yIGlzIHRoZXJlIGEgYmVuZWZpdCB0
aGF0IA0KPj4+PiBJIGFtIG1pc3NpbmcgdGhhdCBuZWVkcyB0byBiZSBzdGF0ZWQ/DQo+Pj4gDQo+
Pj4gWW91J3JlIGZvY3VzaW5nIG9uIHRoaXJkIHBhcnR5IGtlcm5lbCBtb2R1bGVzIGFuZCBmb3Jn
ZXR0aW5nIGFib3V0IHRoZQ0KPj4+IHNpbXBsZSB1c2UgY2FzZSBvZiBhbGxvd2luZyBhbiBlbmQg
dXNlciAob3IgYnVzaW5lc3MpIHRvIHNpZ24gdGhlaXIgb3duDQo+Pj4gY29kZS4gIFRydWUgdGhl
eSBjb3VsZCB1c2UgdGhlIGxlc3MgcmVzdHJpY3RpdmUgQ0EgY2VydGlmaWNhdGVzLCBidXQgaXQN
Cj4+PiBpcyB1bm5lY2Vzc2FyeS4NCj4+IA0KPj4gTXkgZm9jdXMgaXMgb24gc2lnbmluZyB1c2Vy
LXNwYWNlIGFwcGxpY2F0aW9ucywgYXMgb3V0bGluZWQgaW4gdGhlIGNvdmVyIGxldHRlci4gIFRo
aXMgDQo+PiBzZXJpZXMgaGFzIG5vdGhpbmcgdG8gZG8gd2l0aCBrZXJuZWwgbW9kdWxlcy4gIE1v
c3QgZW5kLXVzZXJzIGFuZCBidXNpbmVzc2VzIHJlbHkgb24gDQo+PiBhIHRoaXJkIHBhcnR5IHRv
IGRlYWwgd2l0aCBjb2RlIHNpZ25pbmcuICBBbGwgdGhpcmQgcGFydHkgY29kZSBzaWduaW5nIHNl
cnZpY2VzIEkgaGF2ZSANCj4+IGZvdW5kIHVzZSBhbiBpbnRlcm1lZGlhdGUgQ0EgY29udGFpbmlu
ZyBtb3JlIHRoYW4ganVzdCB0aGUga2V5Q2VydFNpZ24gdXNhZ2Ugc2V0LiAgDQo+PiBJdCBzZWVt
cyB0byBiZSBhbiBpbmR1c3RyeSBhY2NlcHRlZCBwcmFjdGljZSB0aGF0IGRvZXMgbm90IHZpb2xh
dGUgdGhlIHNwZWMuIEJlZm9yZSB3cml0aW5nDQo+PiBuZXcgY29kZSB0byBlaXRoZXIgd2FybiBv
ciBleGNsdWRlIGEgdGhpcmQgcGFydHkgaW50ZXJtZWRpYXRlIENBLCAgSSB3b3VsZCBsaWtlIHRv
IHVuZGVyc3RhbmQgDQo+PiB0aGUgbW90aXZhdGlvbiBiZWhpbmQgdGhpcyByZXF1ZXN0Lg0KPiAN
Cj4gSW4gb2xkZXIgZGlzY3Vzc2lvbnMgdGhlcmUgYXJlIGNvbW1lbnRzIGxpa2UsICJBbnkgQ0Eg
Y2VydGlmaWNhdGUsIG5vDQo+IG1hdHRlciBpZiBpdCdzIGEgcm9vdCBvciBhbiBpbnRlcm1lZGlh
dGUsIG11c3QgaGF2ZSB0aGUga2V5Q2VydFNpZ24NCj4gZXh0ZW5zaW9uLiBJZiB5b3Ugd2FudCB0
byBzaWduIGEgcmV2b2NhdGlvbiBsaXN0IChDUkwpIHdpdGggdGhlIENBDQo+IGNlcnRpZmljYXRl
IGFzIHdlbGwgKHlvdSB1c3VhbGx5IGRvIHdhbnQgdGhhdCksIHRoYW4geW91IGhhdmUgdG8gYWRk
DQo+IGNSTFNpZ24gYXMgd2VsbC4gQW55IG90aGVyIGtleVVzYWdlcyBjYW4gYW5kIHNob3VsZCBi
ZSBhdm9pZGVkIGZvciBDQQ0KPiBjZXJ0aWZpY2F0ZXMuIg0KPiANCj4gVGhlIHF1ZXN0aW9uIGFz
IHRvICJ3aHkiIHRoaXMgY2hhbmdlZCB0byBpbmNsdWRlICJkaWdpdGFsU2lnbmF0dXJlIiB3YXMN
Cj4gcG9zZWQgaGVyZSBbMl0gd2l0aCB0aGUgcmVzcG9uc2UgYmVpbmcgZm9yICJPQ1NQIi4gICBJ
dCBhbHNvIGluY2x1ZGVzIGENCj4gbGluayB0byBFbnRydXN0cyByb290IGFuZCBpbnRlcm1lZGlh
dGUgQ0FzIHdpdGgganVzdCBrZXlDZXJ0U2lnbiBhbmQNCj4gY1JMU2lnbiBrZXlVc2FnZXMuDQo+
IA0KPiBUaGUgbWF0Y2hpbmUga2V5cmluZyBpcyBhIG1lYW5zIG9mIGVzdGFibGlzaGluZyBhIG5l
dyByb290IG9mIHRydXN0LiANCj4gVGhlIG1vdGl2YXRpb24gZm9yIGZ1cnRoZXIgcmVzdHJpY3Rp
bmcgQ0EgY2VydGlmaWNhdGVzIHRvIGp1c3QNCj4ga2V5Q2VydFNpZ24gYW5kIGNSTFNpZ24ga2V5
VXNhZ2VzIGlzIHRvIGxpbWl0IGhvdyB0aGUgQ0EgY2VydGlmaWNhdGVzDQo+IG1heSBiZSB1c2Vk
LiAgVGhleSBzaG91bGQgbm90IGJlIHVzZWQgZm9yIGNvZGUgc2lnbmluZy4NCg0KRmFpciBlbm91
Z2guICBJZiB0aGlzIHdpbGwgYmUgdmlld2VkIGFzIGp1c3RpZmljYXRpb24gZm9yIGFkZGluZyB0
aGUgYWRkaXRpb25hbCANCmNvZGUsIEkgY2FuIHdvcmsgb24gYWRkaW5nIGl0LiAgQWJvdmUgeW91
IG1lbnRpb25lZCBhIHdhcm5pbmcgd291bGQgYmUgbmVlZGVkIA0KYXQgYSBtaW5pbXVtIGFuZCBh
IHJlc3RyaWN0aW9uIGNvdWxkIGJlIHBsYWNlZCBiZWhpbmQgYSBLY29uZmlnLiAgSG93IGFib3V0
IGZvciANCnRoZSBkZWZhdWx0IGNhc2UgSSBhZGQgdGhlIHdhcm5pbmcgYW5kIHdoZW4gY29tcGls
aW5nIHdpdGggDQpJTlRFR1JJVFlfQ0FfTUFDSElORV9LRVlSSU5HIHRoZSByZXN0cmljdGlvbiB3
aWxsIGJlIGVuZm9yY2VkLg0KDQo=
