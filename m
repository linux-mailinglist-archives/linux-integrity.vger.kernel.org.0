Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17DA3EACE5
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Aug 2021 00:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhHLWG3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Aug 2021 18:06:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:34440 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230089AbhHLWG2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Aug 2021 18:06:28 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17CLvDC1020516;
        Thu, 12 Aug 2021 22:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2021-07-09;
 bh=MUmhtrRi5m+BmqnZ37hrPZpIUshbMjgWG3v7gvY8o2M=;
 b=iOaHtvHodBR6PGvbjIcpCOcW1FluxCUyq+B9a5dhTvJJslhGmFMTfmtXNhLqZ3vAzpnJ
 j0vrnqNSoPTzY9cEH4HgmoRc8d3qUpolWNBiMU07fb+OjbChqy9EOYI5pWDFFvqYFAR/
 G2cyn31MbIzg1rI+GrKSC+OsqY9chANWdC/sZU7Hlbtgxhp7BLVA7pz8eLS33vVHjhlQ
 1uowYbhSqlnFqGKhDsuolVUedEJodn4ApxqT+G00w9Scwib7pE456ysJjpZ68uSnvQre
 FUSZclapy9GCYccQEkosshoHYRMrwjrM1fYSR83M3s8yGiU7djhEysp1Hun4p45r8SjO yQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=MUmhtrRi5m+BmqnZ37hrPZpIUshbMjgWG3v7gvY8o2M=;
 b=Rd5iXl7OcW25FiAVminNCwWIRq27hJcWEEGvWO+xjXQE7QE+kyVX6KBPIJj1nkqTJusb
 zO+sG4ha4FWXxuVy+2jbneT9JGQ9iyVcWUPUNi6ZzlqwL29Gnr8A10UIMkxZXt4cmT8+
 08K74Hr5M8nsqt5alSNUgNeHk1+uf6F9syrvom+4N/rdXxdYKrv7ZOMcLtyOKcmoJJJk
 MoTH8On1kkXLSPdXF/ysiNW653otaP+cCkNH7+vSm+cphyee94H4Nwiq7XcZ7pGsKXi9
 3+Ae5oNP2U/0i/n5qjHWEvPb6OdgpBNvqe9BODCSV9q1DkfQTXdmGYgEqNmlYamGG/9F Ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aceudv09s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 22:05:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17CLuVGA083222;
        Thu, 12 Aug 2021 22:05:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3030.oracle.com with ESMTP id 3abjw9d2jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 22:05:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frv4wMCmeTUd5hehUTXPyOKqBb2maKONW2HxvW0o98aAD3ZfsUFUsO0mvtVQwPQ8ZoRoQz9C68jXcrPhWL7VDjDiKEfCPOe/X8iPaGsCcw7qMSE6p8lp24FEw78Vufd1GW2RwhdSPLhRG/UHbnxl6H769esB9XPs2UZvqQOt+SI9AzJBAXTVyUz8+lCepLtFnsLbEKDuRZTpHUqDmsg2Xuhkth43vhRUAkdh1Yp4YgdHKJeBzdLYXR7Xi6ip8wcey7VAfgUy6mE3W6rtKzOKEE4THyyQlYzxhnpbCIbNben2k7S9yQztKtdBlAUFDNHguS++rMVYssSFUDtN9YBVlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUmhtrRi5m+BmqnZ37hrPZpIUshbMjgWG3v7gvY8o2M=;
 b=LwEPcbxW43l0JIbA4irb/UqsIbP+QUs/3qotXGdW0d4SrVfQzSptRzomMfMIO+WBK36ebovJboaBcmS4BoNSjxbB2/BFVFdt9Fm6UfkQ1uPxEubFtcQhD7oJC+/li1MYgtABpH5XDF9fQ2ezleTXDDepzMfZDSIPp5Lk6MTeTjiJBN7NbDZe98fdakxlo+odHDuLKgKMQHk8eO7jb7teo+zEsDgMNWUTNqug1HKqo52ElJ21rj7Tl8cZGmJTg7wlqP7MMd6aI71X4thJpqXrZRKGtJMIRdjQT1yyv/mGdwBj7rotAOl3lUeYhCKLCyQ1Ko+dkeAhRtkdNLCw4wsoAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUmhtrRi5m+BmqnZ37hrPZpIUshbMjgWG3v7gvY8o2M=;
 b=zRECusXjyMt6S5fwN2hwlFqhkjGRltwOIkVIHe/IFARVRw7EcD6TwIQ/6yOVCaAkCUcOlLcDngLb4IG0fXfXIKApO/izoGlebYvLeM3qfwKsF3uQGmHrz9+Ud1vpNw3QlzpcgLsIoayml13MDX4IOV+pw7SzuF0PGHvr4gmLQvE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB4971.namprd10.prod.outlook.com (2603:10b6:610:c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Thu, 12 Aug
 2021 22:04:27 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4394.023; Thu, 12 Aug 2021
 22:04:27 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v3 04/14] integrity: add add_to_mok_keyring
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <20210812193245.yev4gyeuxrfwqfty@kernel.org>
Date:   Thu, 12 Aug 2021 16:04:16 -0600
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        lszubowi@redhat.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        glin@suse.com, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D4320300-80F4-4C4A-AB88-B763486B70B8@oracle.com>
References: <20210812021855.3083178-1-eric.snowberg@oracle.com>
 <20210812021855.3083178-5-eric.snowberg@oracle.com>
 <20210812193245.yev4gyeuxrfwqfty@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: SA9PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:806:21::10) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:2001:92:8000::196] (2606:b400:8024:1010::17c6) by SA9PR13CA0005.namprd13.prod.outlook.com (2603:10b6:806:21::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.11 via Frontend Transport; Thu, 12 Aug 2021 22:04:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea590e46-99be-47d6-9634-08d95ddd26de
X-MS-TrafficTypeDiagnostic: CH0PR10MB4971:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB4971320154BBF946EA97972187F99@CH0PR10MB4971.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g1l5CMuZkS5QT5qH3UYzdpxp0g8+Qa+QM8SXwtfMtkOR+PMMC7NMzdS29A4p2SNr0r4ZuDddV07nGLX91Bxgime5ku2r4e8w6EPcDLX2f0om4CkQSbYfBtU29aYjgNWR473D0FhcnnsJ9wN2ywf/5smPqZOgnMULxNBPA6wwyB/Udcjk/YXtyA7m65IRNiYJ2a+/ex+twVUL1h4AGxkLFxr3nW0ZMlxD1mLgduvEbYhZQtfQiPtUD4LoepPaHfs9xdi0WfU+l9riipBgRX+gKqBUfxJF9csCfDbgWeYdVbBEFh1WtBLy/jmzIILS3BoVVGItYuj3p+3PTdtZeLnOH0Bgg19z8e6+MjNPSs6BueXYVZpPtvAsBqlYjdK4tZY6z3i6T+U4W6UIcfSiHOfkuBn81uzymRkP8gH/KqswNnTbkKpE3Mdf6A28aXz4LUt/fe4586+3adK7httsyw6r6hWmvNhAAKjcN/ycETlRWWt0eEa+8q8MN2TzerNUANs79atlcXt52PxMnnR8dQor/T5fb9/uDaSr7wLenWg+Ter1LIpjRwvO/j72guf496I2ABCy3M10YIgZDDL09bGI0ROS3vYK3Idg82i5nxP1QZlW3trnvkdVjqycj8sdVHGXafWZTT+XgewGdz/GuzhX4GWgT9dfiaiVeBfPiuKQNTcQ9i5pFVDrvNx+/kBxmnDXNVgjYMnprCfBSniqGLJ/EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(136003)(39860400002)(186003)(6486002)(54906003)(52116002)(478600001)(66476007)(66556008)(66946007)(86362001)(38100700002)(5660300002)(2906002)(107886003)(2616005)(8676002)(316002)(7416002)(6916009)(53546011)(44832011)(6666004)(33656002)(8936002)(4326008)(4744005)(36756003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmtobVNvL2taZVZnVGVjNzlDZVJDem5kQVZUc2J2WWs2cTQrdXh6aWdRYWgr?=
 =?utf-8?B?MlNoS3dCNllWSi9ZaXdhZnJCQjlSZjVTM1F6NGZWakRJSVdkSjVPOGNtcVV1?=
 =?utf-8?B?NFplRzNIM3pkdzdONHVPYW04bjZhTUthMjFaZ1k4Mmg4cysrYVM0SjlGbVdF?=
 =?utf-8?B?elYycCtUTkxORUNTbXkyWUJVcFFuYmg5a1YyUHprb0h3OWFXa1JkMk1nTC85?=
 =?utf-8?B?YWtVQTl2M29GcnVJdDBReGc0SzRBS3lyM2ZoNVJxdEpvUTFoT2MyOEppZGJD?=
 =?utf-8?B?UTAxN2kzbkF3WHN4SndsemdQL1VzSlVJTDl1SnpCb0Mzd0MrY3FXVEcwSG9l?=
 =?utf-8?B?SytrSzdLZ2FSSGVhR0tmbkliMUZzY2dqVG0wZ3NJNGlPcnNCWFpvdVBnY2xI?=
 =?utf-8?B?NW5RaTd5TUl0c0M3Vm0yUGhOVVY2clU3S29CNG10VDh3anlTN1VVWGR4cUcw?=
 =?utf-8?B?T29oK3pwYmtoWFZmWEpsMUxENVFVcmR6MVB0S2krRHFPSlUvbGhxVjVJVEpQ?=
 =?utf-8?B?RU80NzZlSXVwYVROVnVWdWs3ZFF3NThYdGpRR2Fud1RCWHl2V2pmNjFyYzRw?=
 =?utf-8?B?RTlqYklIdWh1ZGgrdlJRZDJDOURNRGxLcDhlNGFnczJrZDdZQ3AwaVkyNS9S?=
 =?utf-8?B?Z1pGZjBQemtvOHdzWnBIdDRNM0hhRUpEYTVLNVpXK1BaT0tYeFZpb3FoVVFR?=
 =?utf-8?B?VUVzcHpiMW9ZWlBXZGNISjNPQ2lFTnhFUU9vSTNrU0podkhBK1ZHaFQwZ3JN?=
 =?utf-8?B?YUZtNXZtekNIblppdzJyUzNsSXArYm42V1dOcmh3UU90NjgzUEp2Zy81Qmpo?=
 =?utf-8?B?YXdEUU9hZVh3eVVLQ1hxQWtndWZmYi95NWxVbFJITTRrNDcxbXh5aENjbFR0?=
 =?utf-8?B?RVozQVU0bDRubStPU2NEYXZCckZrQmNFcWNoVkh6WmJva3BPTlVseGRhY0VT?=
 =?utf-8?B?S1ZoeU1BOU5RTk1zVmxJeS9sMHFwSVl6MGwrQ1VTSzR1c3FCZGJLUWdySEg2?=
 =?utf-8?B?OTNHY1BKOEJyc2FNRWtIb21pMlpQSWlqaXVyemtsYlNDQU1INVl2bS9WejBq?=
 =?utf-8?B?elhYdU1ndGM1MGhHcmhyQzVvc2dHZGp2elFZTDBySTJRTnJaY3dzZy9YR2FR?=
 =?utf-8?B?WGJIdTFSUmRVeGs1eFZRMWdUMzNuR2hTc1Vmd000Vm53a1JRN01FSXJhUEZx?=
 =?utf-8?B?blBpZEE5R2o3bmJ1VFRjaG5tSzgvZEIyVUp3Yi9iZS9MQ2lhSnF5TVJVVEs2?=
 =?utf-8?B?ZXVYdUVTVEltUkZuc0loZThmWW8xNDl3Q2lYa1Q0NFFFQ2xGckRaaEdKVEtF?=
 =?utf-8?B?am4xbkltYkpRbEVWeEVBdFpnOFpZTjlLVlBiQWp0V2pEUDVnRzFKRkcwTitZ?=
 =?utf-8?B?RnFMNjlTam9TWlk2VS9xSTBRaHpJdVUxdzdQYUxrSG80T3o5Q2poMjBWQ1J6?=
 =?utf-8?B?ZHU1ZUVkZnQvRXRTK2owa3FLVHFnckNtL2tMVmdqS1JrRDlSV2xIL3g4ZFhq?=
 =?utf-8?B?dVJ0LzY0MVRBdEQrdjBpTDJ4OGd4SUpTWGd4Q1UxZTFHUlpua2g3Zng3eWhx?=
 =?utf-8?B?N05pZ0tuem50WWhSZ0pseklvc1pOLzJIL2M2U0NLbGxpWk9NODdXNTIrL3Vh?=
 =?utf-8?B?ZjN3Q0VnNjNwYjd5MGZHbmtJRWxRV3JHTzFSVmdlZDBlclRCbUpaR3RVZGVr?=
 =?utf-8?B?N09sdW5OU3gwdE0xRjJ5TWllR09RUHFJOWRjWGJ0cEw5N1lXdnQza0lnK2kx?=
 =?utf-8?B?SkVWSGR6dzF3ZEhlc2tOYVRUb1hwWDYrYVhEM3pUWWFHRzk2ZUZGbTRka2VD?=
 =?utf-8?Q?35b7ky53LBU6OREZP0nqiFNuTSFWsQrRi8uRg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea590e46-99be-47d6-9634-08d95ddd26de
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 22:04:27.2187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwdn0D4YUomXcz5zb/5tqDP6rLp/qNTIvOUA4pJcApl8RBMYHQPeeev/BKV5FcfdywBq4swmKJDORV5hf9c7O42L60vRMiUuwyAYtAx44DA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4971
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10074 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=929
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120140
X-Proofpoint-ORIG-GUID: PI1Esf0stZaPW1puZnecDuREOD3cQMEO
X-Proofpoint-GUID: PI1Esf0stZaPW1puZnecDuREOD3cQMEO
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Aug 12, 2021, at 1:32 PM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Wed, Aug 11, 2021 at 10:18:45PM -0400, Eric Snowberg wrote:
>> Add the ability to load Machine Owner Key (MOK) keys to the mok keyring.
>> If the permissions do not allow the key to be added to the mok keyring
>> this is not an error, add it to the platform keyring instead.
>=20
> Should state why it isn't an error for clarity.

I=E2=80=99ll add that in the next round, thanks.

