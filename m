Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7DC68FB2B
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Feb 2023 00:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjBHX1G (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Feb 2023 18:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjBHX1F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Feb 2023 18:27:05 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D4C1166F;
        Wed,  8 Feb 2023 15:27:03 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318Kwhbm021666;
        Wed, 8 Feb 2023 23:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=RyXqKRbSCie/e27WybPtaM4fNyiyBFhWEPLNjuUcRdg=;
 b=oA7cMHGEn+XAdilajVRntlVOwzKSH7gYVpgKYbaL2QKBjSHxgKN6i6ifI6q4ZuoGcuY/
 BESgdydq2fYFc9a8Jp+LonLQ5bq/cWBDiKvwIoLxReTSk9UsxJLuirXDyes4DLmyi2AY
 hcgAtnbjO+fWpUvrvu2DZhfRhOHVZQvPf9PJzcmgXG/8jlIIvbm7rLcZc0fFp6gRtca/
 enWNLh5XXVJ0fneiISNA9ETo5wBXsjTlTZeyHMvaYPL4mfmcUiFbNHbYC3dt0vvzs+Ew
 BQhzhJJQEvRdH5uZn7WysctaJo6RZgap6fR97lU/FkDnAjT/id560P9gdlb2ZvMS+yKX RA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nheyu1ktu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Feb 2023 23:26:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 318N9gTV005884;
        Wed, 8 Feb 2023 23:26:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdt8dys9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Feb 2023 23:26:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkpuMb55ewh/Nzv6Zjj5rjcaJ+qKUF/MkRNGJQ6DH0judRYzFmGUjpf+cwnEdCbJyxO8keXLkr7UERkW3oIVfEJ5JM/dlGARWRaHilzk6SYAgG443FNJad9gkWO/itRmC3+jbGuaxDwLvCEwoWb73gcpXMVMWQR3PGO0VJSAYRwwcGSTL9rFrIV5GyLdPHclfQP0CMWFpbqZJ/0mGVN5KLuVsDT+jHqpAMQdf8xLhILjQNVe5hR1vGE9P8HpEfl7MUf2hcfRq1p2LxnK6eZgFL8mgLBdiy/g0lBgzWml8uXA0LYynQMgro1muzmu5F8eioVG413Gk7JzAjttig8Oqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyXqKRbSCie/e27WybPtaM4fNyiyBFhWEPLNjuUcRdg=;
 b=KSMcwBdycFu9g408cofkYM7YdXJNifqbae3ssO7SX1mkKGW1pmsXoUM/8Qx0UGO5ZI+zqB9sFxijcO2pW0ypcaAVeCW98WUUBSP/XqU2hta/M8jA8h35BKp0Eho/wlZxlaGQcmplcqLfIvDfWDvIyFA7+/zW1dZLus18Aa7alehv9gUQp0mxV3icBDVbErkLb0+Lqn3+DRdBGVb1jv4bJ5u/e7hEg7S0j0g1oNiODaytv/E2jLolFYiHF0CAmWrSDWNlDgXxhv9MlUYGw80YtNJ9AR988zgNVh3Jx4Up2CTsvXhecHImCnwZeqa4ZFPTUa7Ues66fvHqbkSmNbr4yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyXqKRbSCie/e27WybPtaM4fNyiyBFhWEPLNjuUcRdg=;
 b=dkZz5O5rU9QHR05i+g/jhRQzz1i6QNZMOVHoGtkIZpTrk8KChIAysYr3D4vsKaUtcYkCPmSepD0F48Zbm44DQqF5PfwpKLs4e2lUv+3e9Is2PE3CY0Jpz6Uaw9UTP9e9rkv5FyD+pptQuCLvdxzK3BNmst2mzCD4BD3YP5nE2jg=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CO1PR10MB4483.namprd10.prod.outlook.com (2603:10b6:303:98::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.14; Wed, 8 Feb
 2023 23:26:27 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7c66:aec8:b4fd:4554]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7c66:aec8:b4fd:4554%9]) with mapi id 15.20.6086.011; Wed, 8 Feb 2023
 23:26:27 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     Jarkko Sakkinen <jarkko@kernel.org>,
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
        <linux-security-module@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>
Subject: Re: [PATCH v4 0/6] Add CA enforcement keyring restrictions
Thread-Topic: [PATCH v4 0/6] Add CA enforcement keyring restrictions
Thread-Index: AQHZOqBBj6wEVBKZk0ioLpxZPAzd+K7E/1sAgAC06AA=
Date:   Wed, 8 Feb 2023 23:26:26 +0000
Message-ID: <D598759A-48FD-46E2-979C-3022A5920C0F@oracle.com>
References: <20230207025958.974056-1-eric.snowberg@oracle.com>
 <41dffdaeb7eb7840f7e38bc691fbda836635c9f9.camel@linux.ibm.com>
In-Reply-To: <41dffdaeb7eb7840f7e38bc691fbda836635c9f9.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|CO1PR10MB4483:EE_
x-ms-office365-filtering-correlation-id: 4fe0d5c8-5306-4b75-64b0-08db0a2be671
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r9G5WYbuvapSh7IA0gu+IquPgGEMHkpR4mcw1EXxW6AJ/tdMWVYLr7+UDla727S3KT8iKHGVqsheVrCGf/xZxCu37Q5U+QkPhm77u+Cim8I8CGEDeJAbCzK7dSoVSqQLR7FPXiPBaq2XJpcujF+kXWGMByOWpVIWkZUsyX06irV3YVFws1kSMcRZ/4+la6Z+5fojbz6E+sCJVPDjwDcBw94/QcJk2W2ZpRSB9GG4+IF57zQMY+0A/p+LCDSSbH/YUzW4bMBqZCktn5a3rVazBoQ8jLnyAyub2kyqAvbMnB8ywVXWlAQ8bUnKL0CiTaPlZPt8VJi7F/s/0LcbppYy4ngRhX9HEe7Kcxs/6lkbA/vqOETGIS94Yu3IigoZDRtS4qsMyiYQ0JgYttp4Y8TXCxxa5IWqzc3527b8hYUYkwdqETIdViht7/wzdxKSBCgi3XLQeBp6pwWrA9aOXbgzwUhTrnaJFoXmPLY46sJpSVjnYUDZIJmtgL0ZqR2OAoTst+vfUjLYNi/h+EuP/uKHLmPZoFOJBHY4T0QKb9J77BMLDusRbuYoB22UjLXVVo0oAOcqXpMAfajjO36XoZ6iX04Y9lt117BRWMygnY/6/9Zy2Tej5uFfyRlipYM/7thA0CPdbBqeG0j3+Vvej9wefOVXHEm+Kom9jn9RbWc/9NeZzTat28xxR3Kosrd6hchpq+OKqk9FH/NL3gCflthOpGpE4DyJ7FXm+h5qgHD/vuA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199018)(86362001)(33656002)(36756003)(41300700001)(6512007)(53546011)(6506007)(2616005)(8676002)(4326008)(54906003)(64756008)(6916009)(66946007)(76116006)(66556008)(66446008)(6486002)(66476007)(478600001)(5660300002)(38100700002)(122000001)(7416002)(316002)(44832011)(2906002)(38070700005)(8936002)(83380400001)(91956017)(186003)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXlLbE1jZXJZRWhOS1RnbmNwKzcvaXBocWZMYWtMUnRWL01scHQwU1A4MEV5?=
 =?utf-8?B?WXBISWJHVU1RME5FakY0NlA4LzFoelJCeTFuM1ZlWENyeHZTRXY0Rk5pdG1M?=
 =?utf-8?B?VFFPZjNIcEd2eUQ4WlVoQ2pUNWFzaUNQM1poWXBHRk13Y2Qwd1RLM3B4NVJy?=
 =?utf-8?B?c3VYb2ZtcHl6SHBscStqc2VmRUpLbXpoMmJmY2IwdHdqK0tJeGVKUHMwSEda?=
 =?utf-8?B?a21mb2JZM3BjMmJqWXNLNitSdWZGWnNuemRaYTQzcmhOODllYW5WUWxQUDRH?=
 =?utf-8?B?ODlJQlhnMGNYbTgxRUliTXpzSmtlNEtZS1ZmRVdVTEY1dlJZM3FCc2QvZVF4?=
 =?utf-8?B?UVRzMk4rNkhvMyswTU10VEdTbmNyQUNic3AyYmpmVkk0QzU2dzF4a1R4alRO?=
 =?utf-8?B?SHllOWQvMkxwcEtGa0NVZkpjS1J2RW51STlmUGxmYnlZRGZ0RnlJaUtaZDVU?=
 =?utf-8?B?M0Fnbmp2K2owaThHbkdydGZpL2Q1L2hXLzNDUnFHVWxHZTF2NHNYY0VxeTFB?=
 =?utf-8?B?dTE2RHU2c0RKeWIrZVRyaTFTbzhpQTZSUG9lckRoVVZGMVRpSzlqNllqUUcx?=
 =?utf-8?B?Q3NoV05USk9wNlp3d01oUW9aQ01MMStRU2RCd0dlMzVwcUZSNG4wSGQ1T1Iw?=
 =?utf-8?B?OEJvZ3BHdWVvSVp4Z1RDaFVmdlg1WEs0bi91UVZzZGRPbURPTFFWbzY5dCtv?=
 =?utf-8?B?Rjd6L1R2OUtoemczVHpkM2NHNDdZdElkRFV0V09PcGxRYkdNYUIzck5FYmJp?=
 =?utf-8?B?MlVBT1A1Y2R4bGp0S0doWjNybkE1RllKdnJ0UGpRZEMrZnY3SHRQQkRQRGhC?=
 =?utf-8?B?N3hZU3B6cjllUGl4eFFabEZKME1iTU4xMEgrbmhTVmhLOE11bjlCbVpnbXBn?=
 =?utf-8?B?c05rTjQ3MEdpQjlza2FxOUlNcTlOWTlsWnVEVjhoMld6Wm1HSFV0cWxEU1Nh?=
 =?utf-8?B?NW9KRzlya0JvNGpZRmErcTdvUDMzdjFTVlpGRGtmaUhEbDE2T2sxYnU1L3J5?=
 =?utf-8?B?L2Y4bCt3ZE4wcWkzRGtxcktyRWlmcDJnRG0yOTAySHZJaUo3UzBhWUZvemdX?=
 =?utf-8?B?MmtnQVlRcS9pUmtlYUM4YlR2akcxQmpiRHNBcUpKOGNPdk1uUEZzSEc4ejJp?=
 =?utf-8?B?dFVmcWFEdXh1RmRiWkhFRFdpYTZOVVo3clJWY1BoNlpXc2hqbE4wbG05YWpX?=
 =?utf-8?B?T0NXSHAyOFdFekZ3SmJBa1FIc2NBSzdodFhja2R6ZFc0QnAzUGYwNG1SZDgr?=
 =?utf-8?B?SjdxMjI5dnQ2Nm9BSDBMdWRybU9JTVVCS3B1RXBVbnhVb3FjbXBUSWFDcytG?=
 =?utf-8?B?eUpVRHkvc0lJRTJvM211RHBLd0JQZzdwSjlFQzZvbWY3Mk9SUUZaZnc2YVVG?=
 =?utf-8?B?YmZzRko1SWlIV2c5NHJwNXZsN2xBNjlOVTV5b1V4R3BpYW1lbEt0YXVWUlFh?=
 =?utf-8?B?MndiUDkyeHlUWWhzbTN6aXhHWUxtMllBTmRMYU9RbTV0cjhwM2E1dTFWMTJY?=
 =?utf-8?B?aFZPdkg3a2daZnMxTmJhdjFNbE5OV0FnRWFKMU1kOU1YQkY4WDl5M3RhYklr?=
 =?utf-8?B?MzduRUQraGNBeFRjME4vRHY3azJBclMvVUsrUUJJNkZMSzdDNkZZOW0yamhh?=
 =?utf-8?B?elA4VW9HYXFkRlVUcTVnTVhSNDlOZ09yS2Z1cnFNNzBWQm4xWC9LSGhFZFUv?=
 =?utf-8?B?UEthUjZvZ09SdTdhQTQxMlRBWStrbHFSTDhGK2dwVzNKVDhLVEs0TWtsVGhs?=
 =?utf-8?B?bU44aVg1VlVIR0dwOGFpM0YwbDloUHVJbnBWald1RkFMSjA2dkUvSHlxU3ZQ?=
 =?utf-8?B?Y1JpOUhML2h1TU9hQmU3cWRFa2lCYWZFZ3FTZDd5SEpCWXZSVjhBVGJXVVZo?=
 =?utf-8?B?WjBHTDRqLzNCbCs4K2dTTG9Bb0hpT2FDK3ZuRXY5cU5zZzcyTExWWUpPUUZn?=
 =?utf-8?B?bnBYYUdpa3FPYnhLQ1RVSFNydDNEVXlMT1phRnFlRXlwNENpenZueUZGRDBB?=
 =?utf-8?B?STJEbUtFZ0tXdm51bGt4a2FZUG03Tyt0S3k3M3o5d3VzTGpXSWVrN09WQlk0?=
 =?utf-8?B?MHllM084bXdqVUl2aUJ1U2Zzci9wWHRvbk9FYnFvM0t2ZkhTRGc3UDVhV1Nz?=
 =?utf-8?B?SUsxKzBWQnRmK2xBdDRqRUc2akRoV282Qm4vQ2Ivb1hqZzk3S1BKMk9abytM?=
 =?utf-8?Q?I063H6kfQ/aMKqQz5PFrX0nXQrMgX2a31+IMIsks+IGJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37926DF52133D84EAB744904EBBD8183@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aTliN3FFbzBaSStMRWx3MmFqTXpxQjV1aThNaVdpR0EwSTlnRDdzY0laSS9H?=
 =?utf-8?B?cnBPb1h6N3pKU1VFeHpzRUlNckNBZTI3S1RuQ0pDMHJVa2tjQnpjWTZqZHc2?=
 =?utf-8?B?bnA0bXVEY1l1V1ExODJxOVdCdXZMeU9QanFrWGJkTVVPeUFxbU5ETmJaSTdU?=
 =?utf-8?B?dDBBUXZFTzhrN3FzQWU4bUVTRTFzdXo4cmJIQTV5dUVmUm5zZ3JhbXp3bElI?=
 =?utf-8?B?UzZWY3E3NEltN3dFbmx4NGRQYnpqYlBhUzhBNFAwMTNzanJHTWxxOVJoelZh?=
 =?utf-8?B?Um1aVWMwUmxvaUZZaXdIcFJITFdldkhCWDJIQWFsSnNoem1BMUVEUGhhbGZ4?=
 =?utf-8?B?eUhkSWxnSVZnbi9lN3FKZDZVdXhjc2pkS3llQ3RIYVl2d29iYnVGYWJUSjlL?=
 =?utf-8?B?dFlQcjIrdk44amtqdTVYblZPNlo1VEhHNS9EMzQ1OWZJVHdEUGVsQnMvYXVj?=
 =?utf-8?B?MkZhNjloR3ZidmFmZWtOZVdKOEFDMnZnN1hiRXdwbDBTcEhpU0tWdDhpNDZH?=
 =?utf-8?B?MHg2NnFtVkl6emRnUSthQnhqY2ExVHZVdVRlcjU4bUdGVzVjRXVxdE5NV0dR?=
 =?utf-8?B?a0tiZTc5bFBTNTNNNG1oRjR2cGlxSWNqaGIvZjQycGJ3cE5jUklyWXBPa2cz?=
 =?utf-8?B?QWxUcmZ2VkVPa0tFVGE0ajFMdmVnaFdXK055azBOMmpNUGJpKzhWK0VzUnNx?=
 =?utf-8?B?WUVwc1ArTUJlNUE5aFg1RHpNU3BBaVNCWjh6WEtGZ3hiWmVjQ0FKVW4yMnNK?=
 =?utf-8?B?TW5rWisvVENYZ2J3czl0Zmp1eWZjakdPUWFMRnRPWmJCYkRhcDYzbGEyYmxk?=
 =?utf-8?B?WExWejNkWGFaTGJwZG9RNWkvemRCSXRTMjZkbVNwZ0pUbmR4T3BmTWREOUR4?=
 =?utf-8?B?UDRCSlBZRmJ4Ykx0ZWJ5bXdqREY3Q1JibDdzdm9OMDAzS1Q0VzJ5ZXhDc0FR?=
 =?utf-8?B?MzMyazE2ajhDN01HUWU4aFBqQzRWaVdZK2s4ZHZ2RmEybmlpaGdScXl3c2ZZ?=
 =?utf-8?B?QzZKUkhqVVl0MWV3U0FNUEtVbHY1QnpOM0hQU2VpRkFpL2pyWGFMZXFjeEQy?=
 =?utf-8?B?SjlIM3prV1VNVVJBOTNxdE9kelJ2RkQrbERqY0V6d3FXOUp5dTN2TGgzeHd6?=
 =?utf-8?B?NWR4a01ZZmw1UWZ6TWpacTJjM0I2eEF6cmVJTnBUcDRQYmNRUDZmNWtCdFpH?=
 =?utf-8?B?S3BQWEdXWmdYWGdwUGFGOHV5WGU5Y2Npb3FHUTBxdFE1eEd5Uit0Q01yaThS?=
 =?utf-8?B?RCtNQk9RYW9SbjJ0UXZ1bzVRUm43NE1ZZzR0c2tqem5pcStmRE1oWDJEc2t5?=
 =?utf-8?B?NkdIQmpnVXNvS3IrTGdFK25FOEhKNzYxMVNGVVNKMmZBcEthek12ZkdsQ1dk?=
 =?utf-8?B?WUtBSUwyWVY2RlRIbHRkR2dIdzFVR1hWczBSQjlRVHFHdXNqZUgyV0l6dWg2?=
 =?utf-8?B?Y2ZYeXByVXNpSHZKUWk3V0lLeDhLUW5nQXJoZnVlRDJ5NEFsWTR6ZFVUb0Fp?=
 =?utf-8?B?NzYwU2pXelJGSnVUbUxGYkcyNm5PZzZZL0dhT09BVzV2YlJMeTRBNHQyWDZ2?=
 =?utf-8?B?Y0EwNnhmWmt1UmkxL2xDOUtFZC9RM1V5dGUyWFFVSmhjbytQK0NpVndWMERm?=
 =?utf-8?Q?h51WbJGqdXZqQ2w9KsgiWlUwjKiIplX/56RnmN6DbuHc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe0d5c8-5306-4b75-64b0-08db0a2be671
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 23:26:26.8651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q/LK3b/ERvZe2A2g9i9u1sG2nuS4skYMzxlb3NF2FVNLDQhBdT4Tnn2L89dktW24oXW6ugMNtbnVNz0kWIFPYqNlzdjFR3adbI0JE+bFItk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4483
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_09,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080199
X-Proofpoint-GUID: l4PSR5AG0rVD5AF-eZoWmoqoQ1pqaErc
X-Proofpoint-ORIG-GUID: l4PSR5AG0rVD5AF-eZoWmoqoQ1pqaErc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gT24gRmViIDgsIDIwMjMsIGF0IDU6MzggQU0sIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4
LmlibS5jb20+IHdyb3RlOg0KPiANCj4gW0NDJ2luZzogTGVlLCBDaHVuLVlpXQ0KPiANCj4gT24g
TW9uLCAyMDIzLTAyLTA2IGF0IDIxOjU5IC0wNTAwLCBFcmljIFNub3diZXJnIHdyb3RlOg0KPj4g
UHJpb3IgdG8gdGhlIGludHJvZHVjdGlvbiBvZiB0aGUgbWFjaGluZSBrZXlyaW5nLCBtb3N0IGRp
c3Ryb3Mgc2ltcGx5IA0KPj4gYWxsb3dlZCBhbGwga2V5cyBjb250YWluZWQgd2l0aGluIHRoZSBw
bGF0Zm9ybSBrZXlyaW5nIHRvIGJlIHVzZWQNCj4+IGZvciBib3RoIGtlcm5lbCBhbmQgbW9kdWxl
IHZlcmlmaWNhdGlvbi4gIFRoaXMgd2FzIGRvbmUgYnkgYW4gb3V0IG9mDQo+PiB0cmVlIHBhdGNo
LiAgU29tZSBkaXN0cm9zIHRvb2sgaXQgZXZlbiBmdXJ0aGVyIGFuZCBsb2FkZWQgYWxsIHRoZXNl
IGtleXMNCj4+IGludG8gdGhlIHNlY29uZGFyeSB0cnVzdGVkIGtleXJpbmcuICBUaGlzIGFsc28g
YWxsb3dlZCB0aGUgc3lzdGVtIG93bmVyIA0KPj4gdG8gYWRkIHRoZWlyIG93biBrZXkgZm9yIElN
QSB1c2FnZS4NCj4+IA0KPj4gRWFjaCBkaXN0cm8gY29udGFpbnMgc2ltaWxhciBkb2N1bWVudGF0
aW9uIG9uIGhvdyB0byBzaWduIGtlcm5lbCBtb2R1bGVzDQo+PiBhbmQgZW5yb2xsIHRoZSBrZXkg
aW50byB0aGUgTU9LLiAgVGhlIHByb2Nlc3MgaXMgZmFpcmx5IHN0cmFpZ2h0Zm9yd2FyZC4NCj4+
IFdpdGggdGhlIGludHJvZHVjdGlvbiBvZiB0aGUgbWFjaGluZSBrZXlyaW5nLCB0aGUgcHJvY2Vz
cyByZW1haW5zDQo+PiBiYXNpY2FsbHkgdGhlIHNhbWUsIHdpdGhvdXQgdGhlIG5lZWQgZm9yIGFu
eSBvdXQgb2YgdHJlZSBwYXRjaGVzLg0KPj4gDQo+PiBUaGUgbWFjaGluZSBrZXlyaW5nIGFsbG93
ZWQgZGlzdHJvcyB0byBlbGltaW5hdGUgdGhlIG91dCBvZiB0cmVlIHBhdGNoZXMNCj4+IGZvciBr
ZXJuZWwgbW9kdWxlIHNpZ25pbmcuICBIb3dldmVyLCBpdCBmYWxscyBzaG9ydCBpbiBhbGxvd2lu
ZyB0aGUgZW5kIA0KPj4gdXNlciB0byBhZGQgdGhlaXIgb3duIGtleXMgZm9yIElNQS4gQ3VycmVu
dGx5LCB0aGUgbWFjaGluZSBrZXlyaW5nIGNhbiBub3QgDQo+PiBiZSB1c2VkIGFzIGFub3RoZXIg
dHJ1c3QgYW5jaG9yIGZvciBhZGRpbmcga2V5cyB0byB0aGUgaW1hIGtleXJpbmcsIHNpbmNlIA0K
Pj4gQ0EgZW5mb3JjZW1lbnQgZG9lcyBub3QgY3VycmVudGx5IGV4aXN0LiAgVGhpcyB3b3VsZCBl
eHBhbmQgdGhlIGN1cnJlbnQgDQo+PiBpbnRlZ3JpdHkgZ2FwLiBUaGUgSU1BX0tFWVJJTkdTX1BF
Uk1JVF9TSUdORURfQllfQlVJTFRJTl9PUl9TRUNPTkRBUlkgDQo+PiBLY29uZmlnIHN0YXRlcyB0
aGF0IGtleXMgbWF5IGJlIGFkZGVkIHRvIHRoZSBpbWEga2V5cmluZ3MgaWYgdGhlIGtleSBpcyAN
Cj4+IHZhbGlkbHkgc2lnbmVkIGJ5IGEgQ0EgY2VydCBpbiB0aGUgc3lzdGVtIGJ1aWx0LWluIG9y
IHNlY29uZGFyeSB0cnVzdGVkIA0KPj4ga2V5cmluZy4gIEN1cnJlbnRseSwgdGhlcmUgaXMgbm90
IGNvZGUgdGhhdCBlbmZvcmNlcyB0aGUgY29udGVudHMgb2YgYQ0KPj4gQ0EgY2VydC4NCj4+IA0K
Pj4gVGhpcyBzZXJpZXMgaW50cm9kdWNlcyBhIHdheSB0byBkbyBDQSBlbmZvcmVtZW50IHdpdGgg
dGhlIG1hY2hpbmUNCj4+IGtleXJpbmcuIEl0IGludHJvZHVjZXMgdGhyZWUgZGlmZmVyZW50IHdh
eXMgdG8gY29uZmlndXJlIHRoZSBtYWNoaW5lDQo+PiBrZXlyaW5nLiBBIG5ldyBtZW51IG9wdGlv
biBpcyBhZGRlZCB0byBjb250cm9sIHRoZSB0eXBlIG9mIGtleXMgdGhhdCBtYXkNCj4+IGJlIGFk
ZGVkIHRvIGl0LiAgVGhlIG9wdGlvbnMgaW5jbHVkZSBub25lLCBtaW4sIGFuZCBtYXggcmVzdHJp
Y3Rpb25zLiBUaGUNCj4+IGRlZmF1bHQgaXMgQ09ORklHX0lOVEVHUklUWV9DQV9NQUNISU5FX0tF
WVJJTkdfTk9ORS4gVGhpcyBhbGxvd3MgYWxsIE1PSw0KPj4ga2V5cyBpbnRvIHRoZSBtYWNoaW5l
IGtleXJpbmcuICBXaGVuIENPTkZJR19JTlRFR1JJVFlfQ0FfTUFDSElORV9LRVlSSU5HX01JTg0K
Pj4gaXMgc2VsZWN0ZWQsIHRoZSBYLjUwOSBDQSBiaXQgbXVzdCBiZSB0cnVlLiAgQWxzbywgdGhl
IGtleSB1c2FnZSBtdXN0DQo+PiBjb250YWluIGtleUNlcnRTaWduLCBhbnkgb3RoZXIgdXNhZ2Ug
ZmllbGQgbWF5IGFsc28gYmUgc2V0LiBXaGVuIA0KPj4gQ09ORklHX0lOVEVHUklUWV9DQV9NQUNI
SU5FX0tFWVJJTkdfTUFYIGlzIHNlbGVjdGVkLCB0aGUgWC41MDkgQ0EgYml0DQo+PiBtdXN0IGJl
IHRydWUuICBBbHNvLCB0aGUga2V5IHVzYWdlIG11c3QgY29udGFpbiBrZXlDZXJ0U2lnbiBhbmQg
dGhlDQo+PiBkaWdpdGlhbFNpZ25hdHVyZSB1c2FnZSBtYXkgbm90IGJlIHNldC4gSWYgYSBrZXkg
ZG9lc24ndCBwYXNzIHRoZSBDQQ0KPj4gcmVzdHJpY3Rpb24gY2hlY2ssIGluc3RlYWQgb2YgZ29p
bmcgaW50byB0aGUgbWFjaGluZSBrZXlyaW5nLCBpdCBpcw0KPj4gYWRkZWQgdG8gdGhlIHBsYXRm
b3JtIGtleXJpbmcuIFdpdGggdGhlIGFiaWxpdHkgdG8gY29uZmlndXJlIHRoZSBtYWNoaW5lDQo+
PiBrZXlyaW5nIHdpdGggQ0EgcmVzdHJpY3Rpb25zLCBjb2RlIHRoYXQgcHJldmVudGVkIHRoZSBt
YWNoaW5lIGtleXJpbmcNCj4+IGZyb20gYmVpbmcgZW5hYmxlZCB3aXRoIElNQV9LRVlSSU5HU19Q
RVJNSVRfU0lHTkVEX0JZX0JVSUxUSU5fT1JfU0VDT05EQVJZDQo+PiBoYXMgYmVlbiByZW1vdmVk
Lg0KPj4gDQo+PiBDaGFuZ2Vsb2c6DQo+PiB2NDoNCj4+IC0gUmVtb3ZlZCBhbGwgY29kZSB0aGF0
IHZhbGlkYXRlZCB0aGUgY2VydGlmaWNhdGUgY2hhaW4gYmFjayB0byB0aGUgcm9vdA0KPj4gIENB
LiBOb3cgdGhlIG9ubHkgcmVzdHJpY3Rpb24gaXMgd2hhdCBpcyBpbml0aWFsbHkgcGxhY2VkIGlu
IHRoZQ0KPj4gIG1hY2hpbmUga2V5cmluZy4NCj4+IC0gQ2hlY2sgYW5kIHN0b3JlIGlmIHRoZSBY
LjUwOSB1c2FnZSBjb250YWlucyBkaWdpdGFsU2lnbmF0dXJlDQo+PiAtIE5ldyBLY29uZmlnIG1l
bnUgaXRlbSB3aXRoIG5vbmUsIG1pbiBhbmQgbWF4IENBIHJlc3RyaWN0aW9uIG9uIHRoZSANCj4+
ICBtYWNoaW5lIGtleXJpbmcNCj4gDQo+IFRoYW5rIHlvdSwgRXJpYy4NCj4gDQo+IEZvciBjb21w
bGV0ZSBzZXBhcmF0aW9uIG9mIGNlcnRpZmljYXRlIHVzYWdlLCBhdCBsZWFzdCBpbiB0aGUgIm1h
eCIgQ0ENCj4gcmVzdHJpY3Rpb24gY2FzZSwgdGhlIG5leHQgc3RlcCB3b3VsZCBiZSB0byBsaW1p
dCBjZXJ0aWZpY2F0ZXMgYmVpbmcNCj4gbG9hZGVkIG9udG8gdGhlIElNQSBrZXlyaW5nIHRvIHRo
b3NlIHdpdGgga2V5IHVzYWdlIG9mDQo+ICJkaWdpdGFsU2lnbmF0dXJlIi4NCj4gDQo+IFBlcmhh
cHMgYWxzbyByZXF1aXJlIGEgImNvZGVTaWduaW5nIiBleHRlbmRlZEtleVVzYWdlLCB0aG91Z2gg
dGhhdA0KPiBtaWdodCBicmVhayBleGlzdGluZyB1c2FnZXMuICBUaGUgImNvZGVTaWduaW5nIiBj
aGVja2luZyBjb3VsZA0KPiBwaWdneWJhY2sgb24gSm9leSdzIHByb3Bvc2VkICJDaGVjayBjb2Rl
U2lnbmluZyBleHRlbmRlZCBrZXkgdXNhZ2UNCj4gZXh0ZW5zaW9uIiBwYXRjaCBzZXQuDQo+IA0K
PiBXaGF0IGRvIHlvdSB0aGluaz8gIERvIHlvdSBoYXZlIGFueSBjb25jZXJucyB3aXRoIGxpbWl0
aW5nIHRoZSB0eXBlIG9mDQo+IGNlcnRpZmljYXRlIGJlaW5nIGxvYWRlZCBvbnRvIHRoZSBJTUEg
a2V5cmluZyB0byB0aG9zZSB3aXRoDQo+ICJkaWdpdGFsU2lnbmF0dXJlIj8NCg0KSW4gdGhlIE1B
WCBzZXR0aW5nIEkgd291bGQgbm90IGhhdmUgYSBjb25jZXJuLiAgSW5zdGVhZCBvZiByZXN0cmlj
dF9saW5rX3RvX2ltYSANCmJlaW5nIGEgbWFjcm8sIGEgbmV3IHJlc3RyaWN0aW9uIHNpbWlsYXIg
dG8gcmVzdHJpY3RfbGlua19ieV9jYSBjb3VsZCBiZSBjcmVhdGVkLiAgDQpUaGUgbmV3IHJlc3Ry
aWN0aW9uIHdvdWxkIHNpbXBseSB2ZXJpZnkgZGlnaXRpYWxTaWduYXR1cmUgaXMgc2V0IGFuZCB0
aGUga2V5IGNhbiBiZSANCnZvdWNoZWQgZm9yIGJ5IGVpdGhlciB0aGUgYnVpbHQtaW4gb3Igc2Vj
b25kYXJ5IGtleXJpbmdzLiBKb2V54oCZcyB3b3JrIHRvIHBhcnNlIA0KdGhlIGV4dGVuZGVkIGtl
eSB1c2FnZSBleHRlbnNpb24gY291bGQgYWxzbyBiZSBpbmNsdWRlZCBpbiB0aGlzIHJlc3RyaWN0
aW9uLg0KDQpJ4oCZbSBhc3N1bWluZyB0aGlzIHdvdWxkIGJlIGZvbGxvdyBvbiB3b3JrPw0KDQo=
