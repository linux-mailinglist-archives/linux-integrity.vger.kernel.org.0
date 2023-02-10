Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F49692A4B
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Feb 2023 23:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjBJWiy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Feb 2023 17:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjBJWix (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Feb 2023 17:38:53 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C500D1B55B;
        Fri, 10 Feb 2023 14:38:52 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AHwjcX005580;
        Fri, 10 Feb 2023 22:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=faFHGYt++qbbCCMRI3dgKbViQCfL7tEc8FNJkMSjfcg=;
 b=rsgukVemVsb+xrzSm1/swE1K7jzoxD5QbaYaSkW0Blq6tKf3oSxz3v1rsMIs4UDVCvMC
 RC/Z1wBR0Pxzy9rO0EhBf6q5Zx8mLQjcpNrFRGPkaGXY/tdRsIHvZIsoHJqvJdRMMxnR
 gGbxMs5z7MXJGljP26K+gws+VBCdvWAVzYT55ca08HURSU7o+0mwwmIFmHL6axaBzlYf
 jIzk8kbJvbtVxuDvrO+x79e7PgeUBR91mgH58IkOVQyivkzkytYSRKrWXD07VYvaLt2n
 ia0pZo8rgvQsauZc1C1CeNmUwdWZKsBO6TQqKFIRaqvBCzXNXV7iF++ddBrsNDzyn2Hd 9A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhe53pdxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 22:38:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AMNHBO013647;
        Fri, 10 Feb 2023 22:38:16 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtauw7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 22:38:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrtQOJvk8BiRA34cc61BWGpOkAq/iMeZSOCN0SjJsCGnUKruxXmvsPw0yKiQb59KhCZyvNzWRxSFlFCG+CGAlz10ZJMU3CL7oWWOICsPG3jYzQkdKE5ilDGoo7NrA9it67owbRtJdX/W6TyQmkeXDR8FkiiXq+Ms8mZwhM7gLTaBEf7fIsW6Fysj/D1aZehANZXnZa36OvqSt4WdxWApARnpJKZbW6SPIIDKJidLxrCo/NX3tjNbTXsVs2mxozjilODp8Juo5+Ax0AZCRwenr1UeaRDCngKr+HiHEQIgvs/XiN4Etz7MkUB0RmSzYT3/uuXzLAiqWsQdhQ6MHVwZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faFHGYt++qbbCCMRI3dgKbViQCfL7tEc8FNJkMSjfcg=;
 b=kFR1FgNHhhy+xK9wDXBbWazOfF4jtLfc/ITYf3dvHBYZ2nchtR1TbcQTLAnnkEoJ+a+9Q+BO6Td90z9+YHE138G7XRK7Ig2JASK+i/xYcX/hspues5HSZ08ZY4u5w5GTMtZqehSpU8/KTCznf2ClTf3wkKfhX3nz5wDY8Ldy9SLfwJG45CS+xxWcKeqXW+UDnqyEHePKJxAJcbqHVbPygNu+SwcAuhy2YKW1kkog5JxEA1yfWLPIaaasXeRTJdLmIeeo7kaUuPccXERRuozAC6rgmXUAfYZYmXdj21SqixF0OMvOGZIFxhWHQUN9vgujzHVkcx/y8ZoLbOYSaFfcGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faFHGYt++qbbCCMRI3dgKbViQCfL7tEc8FNJkMSjfcg=;
 b=v/JnfuPgF0Qmz1Im0o0J/mu+o5toxY0c5AoQ/N0t284KzGNR8V8+W1hnjAqmDlb/9jOKVw9TUBMwoBXSimelH7VqGMMucOkWUy6Kf65z+SqKsBwIzWVv0xyaujbX4wL9VikFwMJyN0OsEozomVmD3Lwny2tgVQv9zLQjXsp+nt8=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DM4PR10MB7402.namprd10.prod.outlook.com (2603:10b6:8:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 22:38:14 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb%3]) with mapi id 15.20.6111.006; Fri, 10 Feb 2023
 22:38:14 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>,
        "tadeusz.struk@intel.com" <tadeusz.struk@intel.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Elaine Palmer <erpalmer@linux.vnet.ibm.com>,
        Coiby Xu <coxu@redhat.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v4 1/6] KEYS: Create static version of
 public_key_verify_signature
Thread-Topic: [PATCH v4 1/6] KEYS: Create static version of
 public_key_verify_signature
Thread-Index: AQHZOqBC7PEEu1mCWUmKUDpZ/u+7GK7HjU6AgAE+KYA=
Date:   Fri, 10 Feb 2023 22:38:14 +0000
Message-ID: <5E019910-C0C8-4CA9-A2BE-55F5F5061BA2@oracle.com>
References: <20230207025958.974056-1-eric.snowberg@oracle.com>
 <20230207025958.974056-2-eric.snowberg@oracle.com>
 <Y+W8VQnCw2RlwFnH@kernel.org>
In-Reply-To: <Y+W8VQnCw2RlwFnH@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|DM4PR10MB7402:EE_
x-ms-office365-filtering-correlation-id: 6496abf1-c615-46d1-03e5-08db0bb77f11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AtQLt2XavbB706LouvoZkFyAnM0Kr6HSeqjS7uQM6kfqE0G5JeD7xS4D2OfabBncczkyFckEm4q7uGFVCEBUTfuuwbMl0Peyr+/VVb64iVebiXFBhLg9ABEuY6Q79dzSqjECAMav4b6FVI0IzD3pHSnp6QitzS4JLbVxJt0pMNvtxrQRH6OdTf6TaS1Fqugcp1zZhkAuYhbDG20TRPxVewxl7ySC8sl6xjwz/oqamTWgP8aSLdz0KfKYAYVxtrrqtOx4xP/hE8f15JBOv+d1dBa8xp3Hy9j5/+5cmEaVNQHniCRPsVLYKovfcSZjVCLIqxzxar2OCrDWt1HFalBIN1fXkqWw/U2dwDJO2N5u7P0pg5VGaEEmq11dxBFRTZzYmRdIrWaGeFYzDTAb9lrnyGVpKqmYHLoSpVFOMfOqbNcxbjjKIU/eppkjyZU6YHORkLuyHZGNtrsJ1bOuOjY4UOy8B1cAMxMBCTrrWlgGcDcZrJ/Kcfu2+JJiKNJedos9oPwtTo97G9MqkETaBRAKEOHAEYfjfqg7Lrz8uZztfoyh7p7CbxXVzXq/s19at6Fn4qjG79ARlJGRpAVI9y1HLgLXHxy/jCqYBpoCWZM8ZdKLS6mYywAIlJdfe6Y6rxhh3YTgrrWn1wbMllaQDV6Q1OdsoPwGILrz1xyGrc8GD8azB/ewfwxlmIsA0VxsMJQX1EuQ7NOFyeNWCiNnDbTjK8rFfZ9vY5L3xUYjz/DEoybk1t+yDwway+tfH0Apha9UFB+HZeI6d09nZjKdMv6BTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199018)(966005)(86362001)(66556008)(64756008)(7416002)(316002)(54906003)(83380400001)(66476007)(66946007)(8676002)(6916009)(2616005)(5660300002)(41300700001)(478600001)(4326008)(66446008)(8936002)(6506007)(26005)(33656002)(186003)(53546011)(71200400001)(6486002)(6512007)(76116006)(38070700005)(36756003)(4744005)(44832011)(38100700002)(122000001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7OH66BbVbnc9+cDE79SCBOKQA0oe5/vyHPjcBcRnUdqI054+Ubyt0y1LevQY?=
 =?us-ascii?Q?rjfz6G0psuSsaeHVxC36BURNsl+zvA1bFbGvpO3X66nAKH7wLnTkzR4WAz8N?=
 =?us-ascii?Q?w6sgdbKVnjCfXQBSPpyT2sTX3mxC3TqyQVFMsK+vOfKefQ5Qkg/HyZqw5sCJ?=
 =?us-ascii?Q?0jimM6p35101xE5JDbhPIR8M3+ygzxVN04wFMOx65aR1Cy0jqI/gcQ5Sjq9x?=
 =?us-ascii?Q?lYWgjdasyEAZiqL0Fb26CSCHdMuKlf5hlKvAAIk/woW/qfk9aSMenCtQeuqi?=
 =?us-ascii?Q?l1MdKFlju3XjsKQTR+J4ke9p3rV2pG4u7o0gkChdJrzuvzIw1Lik3GrS5Gml?=
 =?us-ascii?Q?UdU4ZDO5ducivruegEI0lHkOORHEIL8IA1k9IBkyuh2GKLznfFjeYt5IJqV5?=
 =?us-ascii?Q?gRbjhoSQlxIlfN115VrTxu/pnQJHk+5MF3H1kSivixf7TV2e7SAOJ07Axl1C?=
 =?us-ascii?Q?Lxy/OYfGOMuzy2P2+/ZJbzUmB4O9d6bx0AYHkXXak8ViT3RLWQy5tiGX+PGv?=
 =?us-ascii?Q?VyTaQqZAxrxYLahgH8Q6DaiTN2EJa5fQzezYJw4fmBt2eH5Sk0dOuTt1j9if?=
 =?us-ascii?Q?VKt70pQlNMWHIWN3RWnte5IFIxtY5VkNp90Gk3NShctXqFaTq0mccf7cHCtA?=
 =?us-ascii?Q?H6DMw0glL3n4rRkGJKVSaHMdk1lKvE+3vPqf/VcpLtGrfrbyldJXpLT3qGjI?=
 =?us-ascii?Q?O/ETW33UWVbHzAKt8S9zm76J7BXIw4F78i7Q4b1DnQmbZyUUUscSlC28TEh+?=
 =?us-ascii?Q?XE7j8JZBeeJMXAK1zCdC+QgGYCJoWVOMTQ4DF1F03kYrDq5mXsoS/2C8Z9OO?=
 =?us-ascii?Q?S6yfg2cZNXFE/jVGHU9nI78vlWop6+8HLCQjIIPkAFJKJngyM8BFm3o3N/LR?=
 =?us-ascii?Q?UHGUwaUXqr3Y/4Lp4nqiPQ0ULDRY3QzSHQMTujXfZxazYDJ9VDT19Pfgs9YX?=
 =?us-ascii?Q?RB90z4106/aw0KNBZek7aiyGwofEXnzZl8Wj9VURaNq8+bSS+pLi/de5bEnM?=
 =?us-ascii?Q?sEGAfTgH6jfiFrbUGphYMlfthymBa5oDNcXO6UbKway8oVDbDlC1yldOIV0x?=
 =?us-ascii?Q?PVcED5VZmeJcu/rzQ5EhBTbhkUrXbNNyZKTDH31wIJabqTuuw5yzgW6kA/Hz?=
 =?us-ascii?Q?P65qPVotQDjHhfd08w5lcokP+kdwTmEOYKcgJMfeqwH7Ro7hF/mu5l9wsFVX?=
 =?us-ascii?Q?Ck3e6/SeDNvRujDY5tz91YWCw2M62wkjTHSmsund93oY5MAlJLFURqKKeKzM?=
 =?us-ascii?Q?uJ5//Oo0klJVfdkTccwnRo37mJ+CMhb7Fd74neVat8QvzCNyP1tHxQ6sU33h?=
 =?us-ascii?Q?OheYqG4aMs8vB+05nu/TW1DW7ZtMRsyMYnPIUgCImLQ1nVu0aQIjXQRT+bOg?=
 =?us-ascii?Q?xqdeAmuqAfmRR3HdnBautg6CB5c0Iw8viUd++wsvRhfpvxRo0dsxv1XlpjaK?=
 =?us-ascii?Q?JXvaROQUdn0g6XYWG4IunYUF+NWaZjg23gHbhEi77AcPoSJTXHPsB10w2eot?=
 =?us-ascii?Q?KV3IBjVrX0raxtAc6VynppXOD60tHHf9rxzaPKgdw77OJU3vTTylwm4kLRt/?=
 =?us-ascii?Q?eQuOzrYylsxYhLfPuL8x3dSigbLNYflxnjWvjrjNFTMOC5Ej/+hnz/xPtcls?=
 =?us-ascii?Q?+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ED6C9645C2858E42A6B0A670BF32DF0F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?HqAf7RCp8+AM9paSP9W+yWgZwxfC5BIJ4SvCBTqPDWO+HVXRgrg+lo0o0INw?=
 =?us-ascii?Q?9Eqxv9sFAxukWNtvs/5fIxrlxu9q6FUhMrMChAue9DL2KIFClgW53gX8BnMu?=
 =?us-ascii?Q?Oc3x7YmAYvnS1xzTo948jnNBbvvgVNWqqrApcQu+J3ivFfvx1Lzoe9lVK9wL?=
 =?us-ascii?Q?7E5ZiS/qSapThpg24c1KgDnOfAHRMdw4hYO8Mtia1PZicEwrMvO/wNjWDko5?=
 =?us-ascii?Q?sXq2UCdYLKSvvSx0UEYMnJE4nfJT545s2gnvj7cSdn2/3dQVpt2EQGuMqEnZ?=
 =?us-ascii?Q?UBOpunJnzGVVYKZu5mcHgrMdU0yJwxS28PjKJfws6ZYbm22JkcWxtnSTOcGS?=
 =?us-ascii?Q?s3GA2wuL7Er6TP7p5grW0iI+xLMLbrSDq+BFonDG1fHNIeRAUpo00QCPvLEb?=
 =?us-ascii?Q?NpQFBZ4VTA+MdeI8XSmwY1mhkrzIalMnu0OkQivt1oCZVFf1QlLjmoCLoiD1?=
 =?us-ascii?Q?TAXF97Hhblum2fUcTPex+78Ll4m2VkG65BorsD9yl4bTRIQ80hnyDjZtOiVz?=
 =?us-ascii?Q?qs0/WVQdJP/MzS0nmoUpkkRwPsa0GmecnbB4AnbHJ1kT+A4hxKcHs8rQRURB?=
 =?us-ascii?Q?/0LM9pM7+m/hJvo+AeiVlsMCh8kpJ6gnduDmY8F5Nz/+Y9zl70svDXpUaSIl?=
 =?us-ascii?Q?MkHw540kfhVvvMrUGekq2S78DWi+1RMFTaxhov16fHrHi57kVpm4Y/FPENju?=
 =?us-ascii?Q?1kTQ5cDemTkjaaVHNtTOUWLZDKp6WF/7G5+UdmtJ1zUsCvcnAxNR4XzmfpEI?=
 =?us-ascii?Q?Smafi633SFSnU9actlCIBLssEdesG1gjxz1PMGWNAwG6qc7uRWkw1M4gAkxj?=
 =?us-ascii?Q?KPBCIi9lblUv1IF8Z6ajm6ukv2dTjPFRt5aCpAWDmb5183DMn0vf4tuilRM/?=
 =?us-ascii?Q?9ASyb23Zd13Ddup2RwyaZ6drQNxEPqSJONEurw0bmNJ43z9nGdUUqwWI2Wd0?=
 =?us-ascii?Q?SQ+J80K5N+IvZhY7s6nkJmd+lPYRriF/8EQLTeQMHTjQOF2qmWkWElYNsNck?=
 =?us-ascii?Q?1yJS1CcXHrLGWH9MXGsNs9I1BZovIjRdO6s1zzQFLJLc+pg3iOVihTwOsZ8r?=
 =?us-ascii?Q?tZx3rlAquxsDF+d32fhLkMNI4/SzdcYHoqCoifNtzL5dX+rPRslC8Xx/j93V?=
 =?us-ascii?Q?qUuk0owj3tohwr5u2g1A1yi3iHFY+NFdASq03okg20ABQmicTQDy4XLIFand?=
 =?us-ascii?Q?QG1YFL5DZsqLcWYbd9i53muVd5c0jTEKtr2NRw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6496abf1-c615-46d1-03e5-08db0bb77f11
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 22:38:14.1174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HM4TkneELHavMJDHwiuvfcNL4h5BCUqLHFCe1AaX/LdOA7X5IQejUbObFe3GDiFKzXxvjKhbbnbuMailrx3Kn2xy9ohPgscvj6ShSLeQkJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7402
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100194
X-Proofpoint-ORIG-GUID: 9JELiq5qRaG4TtgqRmjNZMgHNZ-YZgtD
X-Proofpoint-GUID: 9JELiq5qRaG4TtgqRmjNZMgHNZ-YZgtD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> On Feb 9, 2023, at 8:39 PM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Mon, Feb 06, 2023 at 09:59:53PM -0500, Eric Snowberg wrote:
>> The kernel test robot reports undefined reference to
>> public_key_verify_signature when CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is
>> not defined. Create a static version in this case and return -EINVAL.
>>=20
>> Fixes: db6c43bd2132 ("crypto: KEYS: convert public key and digsig asym t=
o the akcipher api")
>> Reported-by: kernel test robot <lkp@intel.com>
>=20
> What is this reported-by is good for?

Back in September of 2021, I received the following message from the test r=
obot [1]. =20
Within the message it asks that I add the Reported-by tag.  To prevent the =
test robot=20
from generating this error again,  I have included this patch at the beginn=
ing of the=20
series for the last year and a half.  It would be great if someone would ap=
ply the first=20
two patches.

1. https://lore.kernel.org/all/202109161353.wpNkiygQ-lkp@intel.com/

