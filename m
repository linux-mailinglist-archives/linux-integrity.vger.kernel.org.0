Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503F5653654
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Dec 2022 19:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbiLUS2M (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Dec 2022 13:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234842AbiLUS2E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Dec 2022 13:28:04 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9947C2656D;
        Wed, 21 Dec 2022 10:28:01 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BLHDpne014495;
        Wed, 21 Dec 2022 18:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1QiE3/KgHuxOoXxCTTjTJTG8RexqNKWzwQCdF0Gcx/g=;
 b=tKyw1tviq5MwwkrxvFyTHVs+zMl/sLHCpXHGzxRmjexucsGr5AykvcYNhSsKR4wWYoQv
 rg9x/u0YkUNJF/XXYqkjez8EqWAurSishjn2GTqfBP7r8jAzdVauH5I7alvMWb9bzWFf
 2+B5k0TLskCx/hTWpHvZc4mCY79ASk5SrKcHsMYweVFevFRKNQeI9GswYFk41UaAoI3K
 eZ/3qOzeyFE3MJdzF6QVMvK8CmGG/vIW2ZYCOKNQ21YxMIyf2ez+BfjELBAW/aL8cnSU
 /yZOoAKiUVOwR7kRaTcQvgFWnZK5ClkpAv06c36C4XqvGciaGrgSCoW6JTIo/5uaXo5v sw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tn9efq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 18:27:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BLGeKqe012265;
        Wed, 21 Dec 2022 18:27:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mh47774xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 18:27:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKFM5lAVa7ZBNWrzR1tus/44ER7VeESMnT4x9j9Cf/AY63M1bLAXRSgU/OwCk8PPEZE8SnDOb32spqV4Bn47HyCtPxxZRG+y2Efq5U8gx8Bw+PZoOdnBuejFyulPynrIYib2+CT+F9uamRzJ77C7f1oCCkKLLp7y5fOC7cvhgyGkv0Ubs5ZR4HHaPItcvNRTa3IUA3RqfHn40Pm3JiEM3U2Oi765ttMEEDDxQ1LOy7EKH4kk43OUDudrw/YkA9plx/Lro4MPZlQCKdmBnDENgOe6HbIT8OkWSPpJHcB77HLI2RZR7WAORJ+UQg89L219jNzRHTT4jHj2wRLVwUiqag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QiE3/KgHuxOoXxCTTjTJTG8RexqNKWzwQCdF0Gcx/g=;
 b=Qe/ruBwPAAZBrPRBV9aZTrXTi9B/8bkNho6uKAsBjhAvOcVALEMYID8OCphxTF4vAHoPujIJ5TvXhCx/SxM/b8nJhQBhjivUjNIivAX9hPmiU+v06MCMlTg4A6OYhSns3uDPDCY2aPnHiJ4Nkc3GiMESY/ra63c21HZrF4xljSVpGT4JLhEji2j/0RKey+v2Ntkb4rrTaqsyF4p23KATZ+cJ9XWLiBpK6m+B/ddEBXMFXIrq4nXbJrPW8AQY5e649BKWtjsyFRG03Umu1O/CB6ItTdYBJVv2LpLY4HCaUVzrrPNeSiSEbrZPtDteTdKuV2ayHXfvUfh2kLXSMCj9nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QiE3/KgHuxOoXxCTTjTJTG8RexqNKWzwQCdF0Gcx/g=;
 b=WacK0kzgdn9cm8MJAR/sKi87ssYVmIur0wZkDlnTUAvwVY4orDvRhssUb3rpXvqL6WG2mhTNOQoTV4Lz2WEnKbo6GHSDDKQpKY4hCiGL7NhSf3tQtCZofzLYDALSp5YCJ4097aGT0X1UFV2i50G2fgj2zNYbYjoBCjUJ/fPcki4=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DM4PR10MB6184.namprd10.prod.outlook.com (2603:10b6:8:8c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 18:27:18 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 18:27:18 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, Coiby Xu <coxu@redhat.com>
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
Thread-Index: AQHZD1PCFegbrli1zUCp/3TmJTzIr65uvzMAgABmOoCAADsnAIAACGGAgAAJu4CAAAvJAIABEiUAgAMHQoCABR0rgA==
Date:   Wed, 21 Dec 2022 18:27:18 +0000
Message-ID: <0DAFCFC7-29EB-4481-8FF7-616336383378@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
 <b8e54d077da633132eb6da03ea536face095a425.camel@linux.ibm.com>
 <4CE6F17D-9D87-4024-9E1A-FDFE7C29D5FC@oracle.com>
 <1c51910a35a1d113256494827fd66ccc7473632e.camel@linux.ibm.com>
 <17855993-519C-4DAC-B62F-9DB473CF249B@oracle.com>
 <7df94da37c100c160436892a6996ba30e3fd6dc8.camel@linux.ibm.com>
 <21E52C3E-0778-4908-AF44-F65D57BEC4E0@oracle.com>
 <20221216140648.h32gn5qf3igorpzi@Rk>
 <2d75dfd105f8558ecd1074d64e4252ddd63b698b.camel@linux.ibm.com>
In-Reply-To: <2d75dfd105f8558ecd1074d64e4252ddd63b698b.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|DM4PR10MB6184:EE_
x-ms-office365-filtering-correlation-id: 03b8d4f7-c8d0-48b4-d012-08dae380fe09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A2vsfEQ7GsbpB8uiVQOSNlmb8pcOaGEZ3H+8fFdeoHcaeyLY0jsCn1vuz7JmrZuoGvn70s26HvprtPQynOXL3K49NhTXdf4R311W+bwGYLFZqqmcJ+B0Eryuu5wlys55ysLIJNksBneVTCj+i1NvlKwE9bs11QyYydeTZbbDe/eQK27FGX7TebbqfFIeLhMOI4XGzceEMB4nd5f8EHRpgj9sp5sQ/2SSq3Heg1yyrYXeqzWbli38v6RF5XW6dYcfapno59Ccq2Ld2zCNGfkQlhpQ4MsyTomDy7qQdRpra3FVhC++FC9qAoAk3TSHmaKhy+QdygHowfPogi3UI0fpnTKBk+BT0RZ+1Oj9ZoVrCVOyyck6FWIfHMaYrKlsRj8IH+njHTeKsH3kUBMuNJ4rZml1eMkHCKDg9/WhPLuQn+ipJJ8GBLm02w9SdUdhFCHnHWEjdvVK9euyKkgpPli3mopCHfGhGeONEmitZ6QozVUkC9wMjwkPDpOaIo4R+4CKRZuMVfrdddSI/bn7/gjTYIkCQIMnkVYDNZnr9FtF3PgMxBp0d64rKX1P5LXbEvA1N6MAnRYo09zAtnyNyAfPHY6njfnoIl8VF44PXtIckV5bkYWfM82YIYqpx7+7sSAoT4S3USMoIIHVSZ8iKd2GM1mjU6+pENyJsUlCPGxwCYysI/Pl0926JupRkHBogw4gpa5o7iiP8dVFpdgP88YJfzA/Li1LAIWnNctlYzI0CjFDgZHu3rr/DNVeVjx/eNOup6qnWpz0nP5HALXSPWlJiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199015)(44832011)(54906003)(6486002)(38100700002)(110136005)(122000001)(478600001)(2906002)(7416002)(4001150100001)(66446008)(316002)(36756003)(66556008)(38070700005)(8936002)(2616005)(5660300002)(64756008)(86362001)(91956017)(66946007)(76116006)(66476007)(4326008)(8676002)(26005)(186003)(83380400001)(66574015)(71200400001)(33656002)(53546011)(6506007)(6512007)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejBRWlhCRUplTU1tUDhzYTdmY2NNcDBkRXNna2dxOGVJMDlvTmdiMXlwTzZC?=
 =?utf-8?B?a1VDSTgrbnpuWXFJNGxGT1RET3d4OGZGTkRURmZTdXJoOGtYb0JVRzh3dVg1?=
 =?utf-8?B?SENjVFVYenVrd3I2S3FTWVRPRzhETDJmZ0xCaWFlQUtNYkZUSW1MbDUwb0t5?=
 =?utf-8?B?NlFEbmszRFY4cThnczUzN0R2MXVtZnRnVW1Qdzk1eTBRVElxV0ZOblFGSVZ0?=
 =?utf-8?B?Q205elBBdWh6ZC9JLytBQVJBZlgrbUpBeUV0N2VQS2F1Z1lYSzZZTHJMSjlv?=
 =?utf-8?B?RndxeldwR2lZZW5BK3lRTEI3RWRObTdicEVsL0QzOVZNTW9YaUhQeSt3UGFq?=
 =?utf-8?B?bi8vY0FNYkZMSXFjOU5ZRWlXN1d1U3k2TzBJSVJ4RE9Sa1N3TTFhQjkwZDF0?=
 =?utf-8?B?aHdwcStjOTFBSEdReHVCbUVHSElsaHQzcHllNEM1U3JUK2hQKzFHRCtjR2pD?=
 =?utf-8?B?SGh0OWh4WmxpY2d6V1JPeGlZT0U5QlgwRHRNcE1QMWk0eFVRQmtwSVY1c2U3?=
 =?utf-8?B?b2doaUNjUVNUNmgwak9TckRSOFhJYTlxeCtUOXpQUkN2T1YzR0p0NlIvVjlh?=
 =?utf-8?B?MTBQTldidDVHVzFSbU5rNlhNRnRZa2tZdTNTVXNMRUxpSkpueWlTRUFJVVpr?=
 =?utf-8?B?cUs5bTQrWmIya1RKU2pkamt3Q0x1d2NKYjRMT09sem1lcHlMOHFRQStKV0lL?=
 =?utf-8?B?dmRKZENNMi93N0dHcXJaMkEyRlVHWGxmd2M4ZzlKSm50MXBUR3plcTBRODZh?=
 =?utf-8?B?dWoydlE2cE9OckcwcUtjZGxyd1lVM2RMRFcyTzN2UVpUeXZBU0NqK1QwRGtX?=
 =?utf-8?B?RlAxa21mMnRxMmJjZTBPb29IZVZCdVFDdlJ2aVcyZ1JqVmpId0JRc0poUmxw?=
 =?utf-8?B?UkhnYzQvZDJUcFE0K1oxd2xQZmIzamQ2NVc4Yk0xNEZBMWxRSUhMN1hNaWNo?=
 =?utf-8?B?VDRpRm5GSVh2RXhVWlFRZEtreWNSRFZOOU05cjUrWXJudThMbjVJR0FXOTdM?=
 =?utf-8?B?cWVONy8vSFZGdHkxMUFPT2N3cG1TMnB1R3YwM1F0MkVJWXJXNGtEcDhVaklm?=
 =?utf-8?B?NFZnTDU2SXZMc1doeEVIOFFGZEhZOFdscUhobXNqRFRQdGprT0t4bE5nNUVU?=
 =?utf-8?B?djA1RHZmUDlwWVlOUTV6eURvY2cwazFQZi9rbS9FZVE3WlUrRUdGWGhYWGlB?=
 =?utf-8?B?QW9wZnV2YSszbmdNQ3FvbEZucXpXeEpaU0RtNVFOMWJtc0hvV2lqSjU3bVAw?=
 =?utf-8?B?RHA2Qzg1dk1TMkpnN1dqWndteGJxb0ZrKzMzTFNqUlFhdlNsTmQyclk4WmQ5?=
 =?utf-8?B?eHdxekhLRW9IU25rOVVxdGhFOTdMNkVGU2pPOGFBMGQzdDVIYkZDMTVXV0lY?=
 =?utf-8?B?Zno1ZmFIL3lNY3N6dVRTVVZqZTFvWEFHbnZERzlObCtvbUxvU0ZlMUg5Snda?=
 =?utf-8?B?TjEvUkJZMExkeVV6SnYydFJ6TFlKZTg1ZHlydmJLWjl3a01kV1FBNHdwQVpE?=
 =?utf-8?B?QVd5SkNDcktQUkdsdjIvYU04cDNGWEd5cjFZRU1VbVRnbWlOUTFxL0xyTzR3?=
 =?utf-8?B?VHFPa2xKR2U1SUxQbnlYcGhmY1JWenpyRkdrSlI5NFJPNUU0aWJrZHYxbGVK?=
 =?utf-8?B?Sm1QS21ZRm5yWkxzQ2UySTZXZzlLbVBLaXdBQUl0bklPUXNlZ0RGOTc5VC93?=
 =?utf-8?B?R1k2WXhwZlY3OTJoRzkrN1c5cU1UY281K0dqcVVIbE1Na1NLUXRUdWc2S1VY?=
 =?utf-8?B?U2I0RmQ2ZkhOZVBPbDFoMzQ5NmVlZjd0SUhXdENMcWJ2Rlo2cnBYVmhGaXc4?=
 =?utf-8?B?bUxUUDFib09LbG1LdVhoeFMwbGJYa21PTUNoM2FETSsxSFBoaHY3czRJOEpX?=
 =?utf-8?B?cXVDbzFLUHJYcjJKcGdWejE5bmpmQk5CblRzRHhFNWhxdFMwMGluTS9DL0V1?=
 =?utf-8?B?dnRXREtnUjBibFAzb1M2dWJSVEc5MjVhNmVlQlNLSzlGeFh2d0FnUkJYT2tU?=
 =?utf-8?B?T2hmYmpSQk1Vc2MxR21JVFlMYW40K1o3OTFoL3ZndTNVSHJHVGhwT1R4UERv?=
 =?utf-8?B?cXB2ZmVwV2FKNXRTRllqKzhxTVZnZGpwSnY0b1FUaXo3b3BUamtnb0VLZHJ4?=
 =?utf-8?B?a2ZsajF3QUZtOGsyRTNVMWRyWStzVzRjZWJGTlR0UTA5MHZmRnhtT01hY2J1?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F31788DCEC9B44B8A8EFF82A9F47B3C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b8d4f7-c8d0-48b4-d012-08dae380fe09
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2022 18:27:18.3252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N0MgEZ7XLXSZh9G3UnFuseZ7L4IaiZvQMRO/wWsaV6KujeinRa8QvLn2QyKcBLSihyDlp5kjO0MrOwT0pFOiSQ6zcbkV5h+wbkg8PQap5d8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_11,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212210155
X-Proofpoint-ORIG-GUID: 1oXwC_fVBGmDxqiPBIjHaBlGAVA-0VKh
X-Proofpoint-GUID: 1oXwC_fVBGmDxqiPBIjHaBlGAVA-0VKh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gT24gRGVjIDE4LCAyMDIyLCBhdCA1OjIxIEFNLCBNaW1pIFpvaGFyIDx6b2hhckBsaW51
eC5pYm0uY29tPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgMjAyMi0xMi0xNiBhdCAyMjowNiArMDgw
MCwgQ29pYnkgWHUgd3JvdGU6DQo+PiBIaSBFcmljIGFuZCBNaW1pLA0KPj4gDQo+PiBPbiBUaHUs
IERlYyAxNSwgMjAyMiBhdCAwOTo0NTozN1BNICswMDAwLCBFcmljIFNub3diZXJnIHdyb3RlOg0K
Pj4+IA0KPj4+IA0KPj4+Pj4+Pj4+IEEgQ0EgY2VydCBzaGFsbCBiZSBkZWZpbmVkIGFzIGFueSBY
NTA5IGNlcnRpZmljYXRlIHRoYXQgY29udGFpbnMgdGhlDQo+Pj4+Pj4+Pj4ga2V5Q2VydFNpZ24g
a2V5IHVzYWdlIGFuZCBoYXMgdGhlIENBIGJpdCBzZXQgdG8gdHJ1ZS4NCj4+Pj4+Pj4+IA0KPj4+
Pj4+Pj4gSGkgRXJpYywNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gQWxsb3dpbmcgQ0EgY2VydGlmaWNh
dGVzIHdpdGggdGhlIGRpZ2l0YWxTaWduYXR1cmUga2V5IHVzYWdlIGZsYWcNCj4+Pj4+Pj4+IGVu
YWJsZWQgZGVmZWF0cyB0aGUgcHVycG9zZSBvZiB0aGUgbmV3IEtjb25maWcuICBQbGVhc2UgdXBk
YXRlIHRoZQ0KPj4+Pj4+Pj4gYWJvdmUgZGVmaW5pdGlvbiB0byBleGNsdWRlIHRoZSBkaWdpdGFs
U2lnbmF0dXJlIGtleSB1c2FnZSBmbGFnIGFuZA0KPj4+Pj4+Pj4gbW9kaWZ5IHRoZSBjb2RlIGFj
Y29yZGluZ2x5Lg0KPj4+Pj4+PiANCj4+Pj4+Pj4gV2l0aGluIHYyLCB0aGUgcmVxdWVzdCB3YXMg
bWFkZSB0byBhbGxvdyBJbnRlcm1lZGlhdGUgQ0EgY2VydGlmaWNhdGVzIHRvIGJlDQo+Pj4+Pj4+
IGxvYWRlZCBkaXJlY3RseS4gIFRoZSBJbnRlcm1lZGlhdGUgQ0EgcmVmZXJlbmNlZCB3YXMgdGhl
IG9uZSB1c2VkIGJ5IGtlcm5lbC5vcmcuDQo+Pj4+Pj4+IFRoaXMgSW50ZXJtZWRpYXRlIENBIGNv
bnRhaW5zIGJvdGggZGlnaXRhbFNpZ25hdHVyZSBhbmQga2V5Q2VydFNpZ24uICBJZiB0aGUgY29k
ZQ0KPj4+Pj4+PiBpcyBjaGFuZ2VkIHRvIGV4Y2x1ZGUgdGhpcyBjZXJ0aWZpY2F0ZSwgbm93IHRo
ZSByb290IENBIGhhcyB0byBiZSBsb2FkZWQgYWdhaW4uICBJcyB0aGF0DQo+Pj4+Pj4+IHRoZSBp
bnRlbnQ/DQo+Pj4+Pj4gDQo+Pj4+Pj4gVGhhdCBkZWZpbml0ZWx5IHdhcyBub3QgdGhlIGludGVu
dC4gIE5vciB3b3VsZCBpdCBhZGRyZXNzIHRoZSBpc3N1ZSBvZg0KPj4+Pj4+IGEgcGFydGljdWxh
ciBpbnRlcm1lZGlhdGUgQ0EgY2VydGlmaWNhdGUgaGF2aW5nIGJvdGgga2V5Q2VydFNpZ24gYW5k
DQo+Pj4+Pj4gZGlnaXRhbFNpZ25hdHVyZS4NCj4+Pj4+IA0KPj4+Pj4gU29ycnksIEnigJltIG5v
dCBmb2xsb3dpbmcuICBXaHkgaXMgaXQgYW4gaXNzdWUgdGhhdCBhbiBpbnRlcm1lZGlhdGUgQ0Eg
Y2VydGlmaWNhdGUgY29udGFpbnMNCj4+Pj4+IGJvdGgga2V5Q2VydFNpZ24gYW5kIGRpZ2l0YWxT
aWduYXR1cmU/IFdoeSB3b3VsZCB3ZSB3YW50IHRvIGV4Y2x1ZGUgYW4gSW50ZXJtZWRpYXRlDQo+
Pj4+PiBDQSBjZXJ0IGxpa2UgdGhlIG9uZSB1c2VkIG9uIGtlcm5lbC5vcmc/DQo+Pj4+IA0KPj4+
PiBJIG11c3QgYmUgbWlzc2luZyBzb21ldGhpbmcuICBJc24ndCB0aGUgcHVycG9zZSBvZiAia2V5
VXNhZ2UiIHRvDQo+Pj4+IG1pbmltaXplIGhvdyBhIGNlcnRpZmljYXRlIG1heSBiZSB1c2VkPyAg
IFdoeSB3b3VsZCB3ZSB3YW50IHRoZSBzYW1lDQo+Pj4+IGNlcnRpZmljYXRlIHRvIGJlIHVzZWQg
Zm9yIGJvdGggY2VydGlmaWNhdGUgc2lnbmluZyBhbmQgY29kZSBzaWduaW5nPw0KPj4+IA0KPj4+
IEV2ZXJ5IDNyZCBwYXJ0eSBpbnRlcm1lZGlhdGUgQ0EgSSBoYXZlIGxvb2tlZCBhdCBzbyBmYXIg
Y29udGFpbnMgYm90aCBzZXQuIE1vc3QgaGF2ZSBDUkxTaWduIHNldC4NCj4+PiBUeXBpY2FsbHkg
dGhlIHJvb3QgQ0EgY29udGFpbnMga2V5Q2VydFNpZ24gYW5kIENSTFNpZ24sIGJ1dCBzb21lIGFs
c28gaGF2ZSBkaWdpdGFsU2lnbmF0dXJlDQo+Pj4gc2V0LiAgRmluZGluZyBhIDNyZCBwYXJ0eSBJ
bnRlcm1lZGlhdGUgQ0Egd2l0aG91dCBkaWdpdGFsU2lnbmF0dXJlIHNldCBpcyBwcm9iYWJseSBn
b2luZyB0byBiZQ0KPj4+IGNoYWxsZW5naW5nIGFuZCB3aWxsIHNldmVyZWx5IGxpbWl0IHVzYWdl
Lg0KPj4gDQo+PiBIb3cgYWJvdXQgYWxsb3dpbmcgYm90aCBrZXlDZXJ0U2lnbiBhbmQgZGlnaXRh
bFNpZ25hdHVyZSBhc3NlcnRlZCBidXQNCj4+IGlzc3VpbmcgYSB3YXJuaW5nIGZvciB0aGlzIGNh
c2U/DQo+PiANCj4+IEhlcmUncyBteSByYXRpb25hbGUgZm9yIHRoaXMgcHJvcG9zYWwuDQo+PiAN
Cj4+IEkgYXNzdW1lIHdlIHNob3VsZCBjb25mb3JtIHRvIHNvbWUgWC41MDkgc3BlY2lmaWNhdGlv
bnMuIFNvIEkgY2hlY2tlZA0KPj4gIlJGQyA1MjgwOiBJbnRlcm5ldCBYLjUwOSBQdWJsaWMgS2V5
IEluZnJhc3RydWN0dXJlIENlcnRpZmljYXRlIGFuZA0KPj4gQ2VydGlmaWNhdGUgUmV2b2NhdGlv
biBMaXN0IChDUkwpIFByb2ZpbGUiIFsxXSBhbmQgSVRVLVQgWC41MDkgKDIwMTItMTApDQo+PiBb
Ml0uDQo+PiANCj4+IFsxXSBzdGF0ZXMgaW4gNC4yLjEuMy4gS2V5IFVzYWdlLA0KPj4gICAgIklm
IHRoZSBrZXlVc2FnZSBleHRlbnNpb24gaXMgcHJlc2VudCwgdGhlbiB0aGUgc3ViamVjdCBwdWJs
aWMga2V5DQo+PiAgICBNVVNUIE5PVCBiZSB1c2VkIHRvIHZlcmlmeSBzaWduYXR1cmVzIG9uIGNl
cnRpZmljYXRlcyBvciBDUkxzIHVubGVzcw0KPj4gICAgdGhlIGNvcnJlc3BvbmRpbmcga2V5Q2Vy
dFNpZ24gb3IgY1JMU2lnbiBiaXQgaXMgc2V0LiAgSWYgdGhlIHN1YmplY3QNCj4+ICAgIHB1Ymxp
YyBrZXkgaXMgb25seSB0byBiZSB1c2VkIGZvciB2ZXJpZnlpbmcgc2lnbmF0dXJlcyBvbg0KPj4g
ICAgY2VydGlmaWNhdGVzIGFuZC9vciBDUkxzLCB0aGVuIHRoZSBkaWdpdGFsU2lnbmF0dXJlIGFu
ZA0KPj4gICAgbm9uUmVwdWRpYXRpb24gYml0cyBTSE9VTEQgTk9UIGJlIHNldC4gIEhvd2V2ZXIs
IHRoZSBkaWdpdGFsU2lnbmF0dXJlDQo+PiAgICBhbmQvb3Igbm9uUmVwdWRpYXRpb24gYml0cyBN
QVkgYmUgc2V0IGluIGFkZGl0aW9uIHRvIHRoZSBrZXlDZXJ0U2lnbg0KPj4gICAgYW5kL29yIGNS
TFNpZ24gYml0cyBpZiB0aGUgc3ViamVjdCBwdWJsaWMga2V5IGlzIHRvIGJlIHVzZWQgdG8gdmVy
aWZ5DQo+PiAgICBzaWduYXR1cmVzIG9uIGNlcnRpZmljYXRlcyBhbmQvb3IgQ1JMcyBhcyB3ZWxs
IGFzIG90aGVyIG9iamVjdHMuIg0KPj4gDQo+PiBhbmQgWzJdIHN0YXRlcyBpbiA4LjIuMi4zIEtl
eSB1c2FnZSBleHRlbnNpb24gdGhhdCwNCj4+ICAgIk1vcmUgdGhhbiBvbmUgYml0IG1heSBiZSBz
ZXQgaW4gYW4gaW5zdGFuY2Ugb2YgdGhlIGtleVVzYWdlIGV4dGVuc2lvbi4NCj4+ICAgVGhlIHNl
dHRpbmcgb2YgbXVsdGlwbGUgYml0cyBzaGFsbCBub3QgY2hhbmdlIHRoZSBtZWFuaW5nIG9mIGVh
Y2gNCj4+ICAgaW5kaXZpZHVhbCBiaXQgYnV0IHNoYWxsIGluZGljYXRlIHRoYXQgdGhlIGNlcnRp
ZmljYXRlIG1heSBiZSB1c2VkIGZvcg0KPj4gICBhbGwgb2YgdGhlIHB1cnBvc2VzIGluZGljYXRl
ZCBieSB0aGUgc2V0IGJpdHMuIFRoZXJlIG1heSBiZSByaXNrcw0KPj4gICBpbmN1cnJlZCB3aGVu
IHNldHRpbmcgbXVsdGlwbGUgYml0cy4gQSByZXZpZXcgb2YgdGhvc2Ugcmlza3MgaXMNCj4+ICAg
ZG9jdW1lbnRlZCBpbiBBbm5leCBJLiINCj4+IA0KPj4gSSBpbnRlcnByZXQgdGhlIGFib3ZlIHRl
eHRzIGFzIHdlIHNob3VsZCBhbGxvdyBib3RoIGtleUNlcnRTaWduIGFuZA0KPj4gZGlnaXRhbFNp
Z25hdHVyZS4gSG93ZXZlciBbMl0gd2FybnMgYWJvdXQgdGhlIHJpc2tzIG9mIHNldHRpbmcgbXVs
dGlwbGUNCj4+IGJpdHMuIFF1b3RpbmcgQW5uZXggSSwNCj4+IA0KPj4gICAiQ29tYmluaW5nIHRo
ZSBjb250ZW50Q29tbWl0bWVudCBiaXQgaW4gdGhlIGtleVVzYWdlIGNlcnRpZmljYXRlDQo+PiAg
IGV4dGVuc2lvbiB3aXRoIG90aGVyIGtleVVzYWdlIGJpdHMgbWF5IGhhdmUgc2VjdXJpdHkgaW1w
bGljYXRpb25zDQo+PiAgIGRlcGVuZGluZyBvbiB0aGUgc2VjdXJpdHkgZW52aXJvbm1lbnQgaW4g
d2hpY2ggdGhlIGNlcnRpZmljYXRlIGlzIHRvIGJlDQo+PiAgIHVzZWQuIElmIHRoZSBzdWJqZWN0
J3MgZW52aXJvbm1lbnQgY2FuIGJlIGZ1bGx5IGNvbnRyb2xsZWQgYW5kIHRydXN0ZWQsDQo+PiAg
IHRoZW4gdGhlcmUgYXJlIG5vIHNwZWNpZmljIHNlY3VyaXR5IGltcGxpY2F0aW9ucy4gRm9yIGV4
YW1wbGUsIGluIGNhc2VzDQo+PiAgIHdoZXJlIHRoZSBzdWJqZWN0IGlzIGZ1bGx5IGNvbmZpZGVu
dCBhYm91dCBleGFjdGx5IHdoaWNoIGRhdGEgaXMgc2lnbmVkDQo+PiAgIG9yIGNhc2VzIHdoZXJl
IHRoZSBzdWJqZWN0IGlzIGZ1bGx5IGNvbmZpZGVudCBhYm91dCB0aGUgc2VjdXJpdHkNCj4+ICAg
Y2hhcmFjdGVyaXN0aWNzIG9mIHRoZSBhdXRoZW50aWNhdGlvbiBwcm90b2NvbCBiZWluZyB1c2Vk
LiBJZiB0aGUNCj4+ICAgc3ViamVjdCdzIGVudmlyb25tZW50IGlzIG5vdCBmdWxseSBjb250cm9s
bGVkIG9yIG5vdCBmdWxseSB0cnVzdGVkLCB0aGVuDQo+PiAgIHVuaW50ZW50aW9uYWwgc2lnbmlu
ZyBvZiBjb21taXRtZW50cyBpcyBwb3NzaWJsZS4gRXhhbXBsZXMgaW5jbHVkZSB0aGUNCj4+ICAg
dXNlIG9mIGJhZGx5IGZvcm1lZCBhdXRoZW50aWNhdGlvbiBleGNoYW5nZXMgYW5kIHRoZSB1c2Ug
b2YgYSByb2d1ZQ0KPj4gICBzb2Z0d2FyZSBjb21wb25lbnQuIElmIHVudHJ1c3RlZCBlbnZpcm9u
bWVudHMgYXJlIHVzZWQgYnkgYSBzdWJqZWN0LA0KPj4gICB0aGVzZSBzZWN1cml0eSBpbXBsaWNh
dGlvbnMgY2FuIGJlIGxpbWl0ZWQgdGhyb3VnaCB1c2Ugb2YgdGhlIGZvbGxvd2luZw0KPj4gICBt
ZWFzdXJlczogICANCj4+ICAgIOKAkyB0byBub3QgY29tYmluZSB0aGUgY29udGVudENvbW1pdG1l
bnQga2V5IHVzYWdlIHNldHRpbmcgaW4NCj4+ICAgICAgY2VydGlmaWNhdGVzIHdpdGggYW55IG90
aGVyIGtleSB1c2FnZSBzZXR0aW5nIGFuZCB0byB1c2UgdGhlDQo+PiAgICAgIGNvcnJlc3BvbmRp
bmcgcHJpdmF0ZSBrZXkgb25seSB3aXRoIHRoaXMgY2VydGlmaWNhdGU7ICAgDQo+PiANCj4+ICAg
IOKAkyB0byBsaW1pdCB0aGUgdXNlIG9mIHByaXZhdGUga2V5cyBhc3NvY2lhdGVkIHdpdGggY2Vy
dGlmaWNhdGVzIHRoYXQNCj4+ICAgICAgaGF2ZSB0aGUgY29udGVudENvbW1pdG1lbnQga2V5IHVz
YWdlIGJpdCBzZXQsIHRvIGVudmlyb25tZW50cyB3aGljaA0KPj4gICAgICBhcmUgY29uc2lkZXJl
ZCBhZGVxdWF0ZWx5IGNvbnRyb2xsZWQgYW5kIHRydXN0d29ydGh5Ig0KPj4gDQo+PiBTbyBtYXli
ZSBpdCdzIHVzZWZ1bCB0byBhZGQgYSB3YXJuaW5nIGlmIGJvdGgga2V5Q2VydFNpZ24gYW5kDQo+
PiBkaWdpdGFsU2lnbmF0dXJlIGFyZSBhc3NlcnRlZC4NCj4gDQo+IENvaWJ5LCB0aGFuayB5b3Ug
Zm9yIGFkZGluZyB0aGVzZSBkZXRhaWxzLiAgSSB3YXMgaG9waW5nIG90aGVycyB3b3VsZA0KPiBj
aGltZSBpbiBhcyB3ZWxsLiAgSSBhZ3JlZSBhdCBtaW5pbXVtIHRoZXJlIHNob3VsZCBiZSBhIHdh
cm5pbmcuDQoNCkEgd2FybmluZyBjb3VsZCBiZSBhZGRlZC4NCg0KPiBQZXJoYXBzIGluc3RlYWQg
b2YgbWFraW5nIElOVEVHUklUWV9DQV9NQUNISU5FX0tFWVJJTkcgZGVwZW5kZW50IG9uDQo+IElO
VEVHUklUWV9NQUNISU5FX0tFWVJJTkcsIG1ha2UgdGhlbSBhIEtjb25maWcgImNob2ljZSIgdG8g
c3VwcG9ydCB0aGUNCj4gbW9yZSByZXN0cmljdGl2ZSBjZXJ0aWZpY2F0ZSB1c2UgY2FzZSByZXF1
aXJlbWVudHM6ICBhbGwgY2VydGlmaWNhdGVzLA0KPiBDQSBjZXJ0aWZpY2F0ZSBzaWduaW5nIGFu
ZCBkaWdpdGFsIHNpZ25hdHVyZSwgb25seSBDQSBjZXJ0aWZpY2F0ZQ0KPiBzaWduaW5nLg0KDQpB
cyBjb3VsZCBzdXBwb3J0IGZvciBhZGRpdGlvbmFsIHJlc3RyaWN0aW9ucy4NCg0KV291bGQgdGhl
c2UgYWRkaXRpb25zIGJlIHJlcXVpcmVkIHdpdGhpbiB0aGlzIHNlcmllcz8gV2hhdCBpcyBtaXNz
aW5nIGZyb20gdGhpcyANCmRpc2N1c3Npb24gaXMgd2h5IHdvdWxkIHRoZXNlIGFkZGl0aW9ucyBi
ZSBuZWNlc3Nhcnk/ICBXaHkgc2hvdWxkIHRoZSBrZXJuZWwgDQplbmZvcmNlIGEgcmVzdHJpY3Rp
b24gdGhhdCBpcyBiZXlvbmQgdGhlIHNjb3BlIG9mIHRoZSBYLjUwOSBzcGVjPyAgSWYgYSB3YXJu
aW5nIHdhcyANCnRvIGJlIGFkZGVkLCB3aGF0IHdvdWxkIGJlIHRoZSBqdXN0aWZpY2F0aW9uIGZv
ciBhZGRpbmcgdGhpcyBhZGRpdGlvbmFsIGNvZGU/ICBGcm9tIA0KbXkgcmVzZWFyY2ggZXZlcnkg
c2luZ2xlIDNyZCBwYXJ0eSBjb2RlIHNpZ25pbmcgaW50ZXJtZWRpYXRlIENBIHdvdWxkIGJlIGZs
YWdnZWQgDQp3aXRoIHRoZSB3YXJuaW5nLiAgSXNu4oCZdCB0aGlzIGp1c3QgZ29pbmcgdG8gY2F1
c2UgY29uZnVzaW9uPyAgT3IgaXMgdGhlcmUgYSBiZW5lZml0IHRoYXQgDQpJIGFtIG1pc3Npbmcg
dGhhdCBuZWVkcyB0byBiZSBzdGF0ZWQ/DQoNCg==
