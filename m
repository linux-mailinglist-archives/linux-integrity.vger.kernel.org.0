Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C90F64E253
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Dec 2022 21:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiLOU3T (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Dec 2022 15:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLOU3S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Dec 2022 15:29:18 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69366389FF;
        Thu, 15 Dec 2022 12:29:16 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFKQdVs020236;
        Thu, 15 Dec 2022 20:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=cCcB5bngjLJO6B27QvqRUrkd9wv9p6X8GK3me91QM28=;
 b=H7zA2XOzY2xpT+Qn9LpQ7P6k1WHNB0YoIYCrTPW2FMgfK+6gHB8m7uKVA5DQMfU/vsCo
 5zu6BEKQ6IpqcUMlcI/KHjylxfo/Mm6EktWjiAS8DFoM70ZcXO1SryAIrgTZDR14hM1Y
 dhzrO5/dbd3EiabWKn+BF5ricEoxjCyiUWqDj3XJWnkCY3RKttKkKJXl7UFwUtSejXC/
 5IJfvgfIMMJ8ImqLpKg5F+C8Su4zJBwJ+PdkoQhv7GpCK1c8dHd0zpIXMXC4+a4WjSV9
 R82TXomG7ewmtuC7sbhFudXzIjsIqH/hcHv6qL90gOhE41dBdxnvt0DYPxdGLolWKOoa IQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyewe1tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 20:28:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BFIva7h028901;
        Thu, 15 Dec 2022 20:28:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3meyeybreh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 20:28:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lm7P9TG68Wqw6qD3wZ7qK3XLsqDjIvIy7tmX5ScpqEIBSELV43p7WeMRxadAavfNgErfJf28PihaUnDC0aAZn7vy6aKgVQj8Azpev1E7WZWl4X1vuesDv9Gdx5EVOz2wM/0blm4bWpx72lbYfjgYSpLXuV3F7cTOdZmhGjnPvn4DWX/GkYJr07+CHi3X0N1AVkfhBdIC9ZPTvttaKLAMG6dpGvm8ovJF0BDVMR4zEFCjUALN5ubzoMNBz6Xk9wjY8pNJUjisTM9BGRqF6dbs1csJiVnMQUkYumjIJyVGiRORaEPSNTVnsYjFUY4dYgJm3Dm4F1nLk9s7CpKa72nPrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCcB5bngjLJO6B27QvqRUrkd9wv9p6X8GK3me91QM28=;
 b=Es1VD21IjL3h7mOSErig9e0DyouIilx79MJHeNy123RVK86Or9FZtf1XtJa/s2IUjZhK8dzOEktLfM5DT40cNpyorTh6pA0cfZJRKCPh7DnC55S+wZu6V2WMzirvriGyQys/4J7ryOIAhQI2S5T2xEPdVYtzd31pTZxAC7QylSPd/PWkeh/lwTYSP9OWG/Mqo6Jp1IbFMFmKVL9cISHazGXObnS0sI2U+B0KiZxSJULATbKMiSLWSi0HewyR8skZfBgYLpdaE8KDiXlO8HPmaBFE9/3Luo9cEEHIgir7PaMGa4rFvp1Jt6oGDh2xKwIkjl+aRvyAWoHimmPDNUF/WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCcB5bngjLJO6B27QvqRUrkd9wv9p6X8GK3me91QM28=;
 b=p9i5i01Hcx2YiLmq7wicVacZrRLqPbJcaWmJTs2JW26N/tGc8b65gVe6k+pxgRdr4VDp5cS8i/Qt1jE9UnmF5eDCW95Np4Xdw5YCvo19QgtTsInVo2it5gWBRW4nQnu1LCVuNALuGmx//Llb4uyO0ViuVqOZ5hN+2ygWOHPt7g4=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS7PR10MB5182.namprd10.prod.outlook.com (2603:10b6:5:38f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 20:28:37 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 20:28:37 +0000
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
        "noodles@fb.com" <noodles@fb.com>, "tiwai@suse.de" <tiwai@suse.de>,
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
Subject: Re: [PATCH v3 00/10] Add CA enforcement keyring restrictions
Thread-Topic: [PATCH v3 00/10] Add CA enforcement keyring restrictions
Thread-Index: AQHZD1PCFegbrli1zUCp/3TmJTzIr65uvzMAgABmOoCAADsnAIAACGGA
Date:   Thu, 15 Dec 2022 20:28:37 +0000
Message-ID: <17855993-519C-4DAC-B62F-9DB473CF249B@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
 <b8e54d077da633132eb6da03ea536face095a425.camel@linux.ibm.com>
 <4CE6F17D-9D87-4024-9E1A-FDFE7C29D5FC@oracle.com>
 <1c51910a35a1d113256494827fd66ccc7473632e.camel@linux.ibm.com>
In-Reply-To: <1c51910a35a1d113256494827fd66ccc7473632e.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|DS7PR10MB5182:EE_
x-ms-office365-filtering-correlation-id: d4139c5d-8451-4c56-6a31-08dadedaf20c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gjbl/T5Cp3i2tUdJ6zoUoP+wHZsbj8CBVHQh6aUfUanCTzevrKWdYR5hJh3XqMN7tLiNYoRedU8yksGJzVErY18Aliv3gbCGY25KSeyI/vJAz24sk9hAPR81jOTLykmPyQn/I8X/lcFrnKKa8KcHt0Ic3PrmbVu2CcrnrG7Sjb1OMpY9j3WOy3KHj+g1salRSPWo5Jt21F93MJElnMCw+BFQqUTM5SrYP56mwF4felSXzXMrCSaZ7Kw7x32SeKKS+Zaak0D3I1dUQS3pdFbNV2fMlkZQPYzNd5g3Hbm07Iog3hMMnz5Y5slowKCCmlROzQgxC8kOwZldko5LHd3OKwbqLhElEhjZFgwfsLGLRgrMG7O2mYtDQVIzab2dNaB8BNHeqCpIVxDA7htDeDKWO3cQUx9aBSVLzQwMO0ExTwLqg8OlqrBai697lHunfMPeEvYwr1ptGJedOAIv/NEMFrD9OMntufZtSbDwm7Yfy8aoGEDupqs+ptd6qBf1BcAhvqxFvrbo+6Cdb6jbgtsL18S+k6zUqQMzRytt//ZFTfr+j9HWR7qHQx3ktuHSS1hAZ8+bN9w6TxDpBjOY57aZIVJF2fz9l2fhZaWpGsmrZ3VeQIwzBxviy3QyHnamVMxKyg+seWGWv/QkIs7shGRspwzKG/z1VWLBajC5gUUdCZX8r+UQ9zR/CL25IoVBmSoKaFMdNrhJu2kUOtYBakQZgQrjx6e+eHa2/jT+va12two=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199015)(36756003)(33656002)(41300700001)(8936002)(71200400001)(86362001)(122000001)(6486002)(38100700002)(478600001)(2616005)(5660300002)(44832011)(53546011)(8676002)(38070700005)(66446008)(66946007)(64756008)(76116006)(6506007)(6916009)(4326008)(7416002)(66556008)(6512007)(26005)(4001150100001)(66476007)(83380400001)(316002)(186003)(2906002)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ancvUW95dlJZMyt6TzkySTJsd3V2Ni9RWTFnUGxYeUlhWUlsTFlSb1crWENS?=
 =?utf-8?B?M3NoZktYUW45U0NEdWoxbjBYQXNMbVZnRCtULzhZS05YdUVmVUlSaklLNGY4?=
 =?utf-8?B?aStwWUFIdXkwbVAwdWhVclNMa013TzREV2lEdmF3cXhkN1JsU1hPVktRaThD?=
 =?utf-8?B?NlQvMFozMmM0TFRKRE5UbXNVL3pEajIzZDFoam5xb2p0NGpFVlpMTkJZMUpW?=
 =?utf-8?B?Nk9SVnpuLytMbGMwTm5NTncrRWwvM2xtblB1anI1Q09qU0hUc1F5QUk5SklW?=
 =?utf-8?B?eDkvWVJtUVQrNkFwNnhVM1R2Q1kveFRWbG9FakFPaFZvTnhPVWN3ZWZsSDVk?=
 =?utf-8?B?bGhMV1N2WFhUanplMGIwUjJQQVh3a3hwM2VuS1M3MlROTDFhRGcyZGtOWVJB?=
 =?utf-8?B?WnRpL1ZhN2lHL3JHZ2phU1lhM214akVDa2VueWVMaUpKdkdkbG1DY1RBcDdw?=
 =?utf-8?B?NnIrbHdvSGJuWTM3MVFhWk9vZnRkeVcwaG9hUlA5MndoeCtuU3JtYWswb2la?=
 =?utf-8?B?T2Y4ODNnSElQanNmN09nZ0s5US9zT3YzcFdnU0ZLanVETGdPU2M2Z0ZNdTZz?=
 =?utf-8?B?bFFxeWhnZm5HUlFNelJBd2x0WThLWFFuR2ZuNlRlSXNCa3dSSFRhOFpEM0pL?=
 =?utf-8?B?T29NQ1dOVjZqckw1L2gyNysyVWUram5WU3hmYmdsTWdvTkZ6UlNLK21oRVls?=
 =?utf-8?B?T0FsQ3dGWUsycVkxSUEzeXkzN3FrM3dxZXNFZ2FVQytvbWoyVkdSYk5lSXpN?=
 =?utf-8?B?TTJWZG1SaVd6RUJ4QWZLNE9iNDRUV2F1TmwvZnc3VVpGd3oxc1hvcy93Rjhp?=
 =?utf-8?B?bHUxVkdjRzQ4MWtaNWdrdkIxWlY2akpjWFJMbTdXZ3ZJNjJiUW8weTBtTHNH?=
 =?utf-8?B?MEVCUVJGeDl1cHE5QlE2RDFUL29DeWUrNkl2aDNwUjdpY2x1WlVGdlg1bUMv?=
 =?utf-8?B?ZmlqT3RxZHNqbXBuSmZhdVpkMEx0bG5ra2MrTVBiOHlVVm10TnNoSFdTUFkr?=
 =?utf-8?B?QlM2a1Z0NmtUeDZKTDYxbnE0Z09sM0pEMEp1S0hDV3I1cEJQaXZVeHdNYkdr?=
 =?utf-8?B?SEtmbll1NHhaOWU3eGdsRGpWMllyTFRibk5FZFJ3cHV1YjkzazFMR3ZvN3I0?=
 =?utf-8?B?Z1ozOE5WRERkSFZ4UFVYZHZuczhSTEF1RnN0UE5aOWE3Mm1yMmNmcEJhekJG?=
 =?utf-8?B?UFdnZ0J4NmQ5ZGVKVnMxVUt5bTd6ZmM0aElYdGdDSXhBS251dm1Tc0hzR0pt?=
 =?utf-8?B?MWp3bWlYTFBKWC9aM05qV0dXTXhmMDErM0lNRENnRlVJQjRYUllEWUFycVlv?=
 =?utf-8?B?QWp0MnBVYndhNVNDa25qUWcvZ0dDNG5PeU5BWVdJUDFmV2svZzRIT1gxV3A2?=
 =?utf-8?B?TUlDdldGeGY0U0tmNkFPdDhVcnZudEJwODVnNEorSFFVZjRkNTNSR2RqU2di?=
 =?utf-8?B?Wk9SY3ZpUkEvY0t5ZHhOazNlN3gwcEhOcnkzYUtteGdtV1pETnIrSXBIQ1B5?=
 =?utf-8?B?eXZEbjUyN3hkTHIrNG52M1lMdmxHZC9hNjZHby9KckMrejJGc05nSzZzODY1?=
 =?utf-8?B?bHRjMERkY2Q3STJ0Tk5meG4xSVRqM0hLakF4dHdhZ04vVTVCcUlkMUxIU24r?=
 =?utf-8?B?TzgrdWFJQkdRdnZCREZHclRDYWpyUDdPaHcvQkJLT3VYbWNSRjJzTkhaV241?=
 =?utf-8?B?Q3p1dlJ3RFdQNUsyVU83S3daUnhacXBkeXdyRGxiTUVrZU1ZUThtVTJGZ0FH?=
 =?utf-8?B?azJKVGVnVnJWbEVKOEhPVjJGUHlmSFZPN0NlazJGMU9JYlE4cUN3SGtGTkJ1?=
 =?utf-8?B?WXZ0aWZPdXBNeTRLSC9hWk5EN0ljd3lRaURNRWM2U2RaYitlVkRHSWRLbmlK?=
 =?utf-8?B?V0d4ZDY1eDlxYkpHUzRnVlhEVDJBZ2h3cmJNQk51Z0pRdEgvUmxIU0J2NXNs?=
 =?utf-8?B?VndjeEpqN1lYSjRMNE92d2liZVkyblNXQllJSHU2UXR5THYxb2o2dTBVSzZv?=
 =?utf-8?B?dFJ2aStqYWRtZWRNZmhiQXdnRUZvNnppV1JMNGRzY0doL2FkR0h5cWlIYWta?=
 =?utf-8?B?Mk5WSXBzRnBvR1ZVWkg2Wm1PU3plbkhVUktFQ2lxYllBK3lYQUJ2OUNFYmpm?=
 =?utf-8?B?dk4xWW4xVEM0aEw4bnNoUnNualhPbm14aDl1bmxTNVFXVXU5OUt5bmp5U3gy?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA35212FBE20A54DB2083C2AE64C502A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4139c5d-8451-4c56-6a31-08dadedaf20c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 20:28:37.1014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZEXaGVGpXSI0GnBNhjwiqBnJ/hbrszFoIe2BJX6ICt3hcZjKZ10Q6Z/PS04VHZUR6UJVHFXxY1NtJH7KMuebLvmLFWFwmKVKq+NXxHFDdAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_11,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212150171
X-Proofpoint-GUID: gj_JXV1RwvwCTXjLx_NVbGXGIfmucXdF
X-Proofpoint-ORIG-GUID: gj_JXV1RwvwCTXjLx_NVbGXGIfmucXdF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gT24gRGVjIDE1LCAyMDIyLCBhdCAxMjo1OCBQTSwgTWltaSBab2hhciA8em9oYXJAbGlu
dXguaWJtLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIDIwMjItMTItMTUgYXQgMTY6MjYgKzAw
MDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+PiANCj4+PiBPbiBEZWMgMTUsIDIwMjIsIGF0IDM6
MjEgQU0sIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+
IE9uIFR1ZSwgMjAyMi0xMi0xMyBhdCAxOTozMyAtMDUwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToN
Cj4+Pj4gUHJpb3IgdG8gdGhlIGludHJvZHVjdGlvbiBvZiB0aGUgbWFjaGluZSBrZXlyaW5nLCBt
b3N0IGRpc3Ryb3Mgc2ltcGx5IA0KPj4+PiBhbGxvd2VkIGFsbCBrZXlzIGNvbnRhaW5lZCB3aXRo
aW4gdGhlIHBsYXRmb3JtIGtleXJpbmcgdG8gYmUgdXNlZA0KPj4+PiBmb3IgYm90aCBrZXJuZWwg
YW5kIG1vZHVsZSB2ZXJpZmljYXRpb24uICBUaGlzIHdhcyBkb25lIGJ5IGFuIG91dCBvZg0KPj4+
PiB0cmVlIHBhdGNoLiAgU29tZSBkaXN0cm9zIHRvb2sgaXQgZXZlbiBmdXJ0aGVyIGFuZCBsb2Fk
ZWQgYWxsIHRoZXNlIGtleXMNCj4+Pj4gaW50byB0aGUgc2Vjb25kYXJ5IHRydXN0ZWQga2V5cmlu
Zy4gIFRoaXMgYWxzbyBhbGxvd2VkIHRoZSBzeXN0ZW0gb3duZXIgDQo+Pj4+IHRvIGFkZCB0aGVp
ciBvd24ga2V5IGZvciBJTUEgdXNhZ2UuDQo+Pj4+IA0KPj4+PiBFYWNoIGRpc3RybyBjb250YWlu
cyBzaW1pbGFyIGRvY3VtZW50YXRpb24gb24gaG93IHRvIHNpZ24ga2VybmVsIG1vZHVsZXMNCj4+
Pj4gYW5kIGVucm9sbCB0aGUga2V5IGludG8gdGhlIE1PSy4gIFRoZSBwcm9jZXNzIGlzIGZhaXJs
eSBzdHJhaWdodGZvcndhcmQuDQo+Pj4+IFdpdGggdGhlIGludHJvZHVjdGlvbiBvZiB0aGUgbWFj
aGluZSBrZXlyaW5nLCB0aGUgcHJvY2VzcyByZW1haW5zDQo+Pj4+IGJhc2ljYWxseSB0aGUgc2Ft
ZSwgd2l0aG91dCB0aGUgbmVlZCBmb3IgYW55IG91dCBvZiB0cmVlIHBhdGNoZXMuDQo+Pj4+IA0K
Pj4+PiBUaGUgbWFjaGluZSBrZXlyaW5nIGFsbG93ZWQgZGlzdHJvcyB0byBlbGltaW5hdGUgdGhl
IG91dCBvZiB0cmVlIHBhdGNoZXMNCj4+Pj4gZm9yIGtlcm5lbCBtb2R1bGUgc2lnbmluZy4gIEhv
d2V2ZXIsIGl0IGZhbGxzIHNob3J0IGluIGFsbG93aW5nIHRoZSBlbmQgDQo+Pj4+IHVzZXIgdG8g
YWRkIHRoZWlyIG93biBrZXlzIGZvciBJTUEuIEN1cnJlbnRseSB0aGUgbWFjaGluZSBrZXlyaW5n
IGNhbiBub3QgDQo+Pj4+IGJlIHVzZWQgYXMgYW5vdGhlciB0cnVzdCBhbmNob3IgZm9yIGFkZGlu
ZyBrZXlzIHRvIHRoZSBpbWEga2V5cmluZywgc2luY2UgDQo+Pj4+IENBIGVuZm9yY2VtZW50IGRv
ZXMgbm90IGN1cnJlbnRseSBleGlzdC4gIFRoaXMgd291bGQgZXhwYW5kIHRoZSBjdXJyZW50IA0K
Pj4+PiBpbnRlZ3JpdHkgZ2FwLiBUaGUgSU1BX0tFWVJJTkdTX1BFUk1JVF9TSUdORURfQllfQlVJ
TFRJTl9PUl9TRUNPTkRBUlkgDQo+Pj4+IEtjb25maWcgc3RhdGVzIHRoYXQga2V5cyBtYXkgYmUg
YWRkZWQgdG8gdGhlIGltYSBrZXlyaW5ncyBpZiB0aGUga2V5IGlzIA0KPj4+PiB2YWxpZGx5IHNp
Z25lZCBieSBhIENBIGNlcnQgaW4gdGhlIHN5c3RlbSBidWlsdC1pbiBvciBzZWNvbmRhcnkgdHJ1
c3RlZCANCj4+Pj4ga2V5cmluZy4gIEN1cnJlbnRseSB0aGVyZSBpcyBub3QgY29kZSB0aGF0IGVu
Zm9yY2VzIHRoZSBjb250ZW50cyBvZiBhDQo+Pj4+IENBIGNlcnQuIEFueSBrZXkgaW4gdGhlIGJ1
aWx0aW4gb3Igc2Vjb25kYXJ5IGtleXJpbmcgY2FuIGJlIHVzZWQuIA0KPj4+PiANCj4+Pj4gVG8g
YWxsb3cgSU1BIHRvIGJlIGVuYWJsZWQgd2l0aCB0aGUgbWFjaGluZSBrZXlyaW5nLCB0aGlzIHNl
cmllcyBpbnRyb2R1Y2VzDQo+Pj4+IGVuZm9yY2VtZW50IG9mIGtleSB1c2FnZSBpbiB0aGUgY2Vy
dGlmaWNhdGUuIFRoaXMgc2VyaWVzIGFsc28gYXBwbGllcw0KPj4+PiB0aGlzIGVuZm9yY2VtZW50
IGFjcm9zcyBhbGwga2VybmVsIGtleXJpbmdzLg0KPj4+PiANCj4+Pj4gVGhlIG1hY2hpbmUga2V5
cmluZyBzaGFyZXMgIHNpbWlsYXJpdGllcyB3aXRoIGJvdGggdGhlIGJ1aWx0aW4gYW5kDQo+Pj4+
IHNlY29uZGFyeSBrZXlyaW5ncy4gIFNpbWlsYXIgdG8gdGhlIGJ1aWx0aW4sIG5vIGtleXMgbWF5
IGJlIGFkZGVkIHRvIHRoZQ0KPj4+PiBtYWNoaW5lIGtleXJpbmcgZm9sbG93aW5nIGJvb3QuIFRo
ZSBzZWNvbmRhcnkga2V5cmluZyBhbGxvd3MgdXNlcg0KPj4+PiBwcm92aWRlZCBrZXlzIHRvIGJl
IGFkZGVkIGZvbGxvd2luZyBib290OyBob3dldmVyLCBhIHByZXZpb3VzbHkgZW5yb2xsZWQNCj4+
Pj4ga2VybmVsIGtleSBtdXN0IHZvdWNoIGZvciB0aGUga2V5IGJlZm9yZSBpdCBtYXkgYmUgaW5j
bHVkZWQuIFRoZSBzeXN0ZW0NCj4+Pj4gb3duZXIgbWF5IGluY2x1ZGUgdGhlaXIgb3duIGtleXMg
aW50byB0aGUgbWFjaGluZSBrZXlyaW5nIHByaW9yIHRvIGJvb3QuDQo+Pj4+IElmIHRoZSBlbmQt
dXNlciBpcyBub3QgdGhlIHN5c3RlbSBvd25lciwgdGhleSBtYXkgbm90IGFkZCB0aGVpciBvd24g
a2V5cw0KPj4+PiB0byB0aGUgbWFjaGluZSBrZXlyaW5nLiAgDQo+Pj4+IA0KPj4+PiBUaGUgbWFj
aGluZSBrZXlyaW5nIGlzIG9ubHkgcG9wdWxhdGVkIHdoZW4gU2VjdXJlIEJvb3QgaXMgZW5hYmxl
ZC4gIEENCj4+Pj4gc3lzdGVtIG93bmVyIGhhcyB0aGUgYWJpbGl0eSB0byBjb250cm9sIHRoZSBl
bnRpcmUgU2VjdXJlIEJvb3Qga2V5Y2hhaW4NCj4+Pj4gKFBLLCBLRUssIERCLCBhbmQgREJYKS4g
IFRoZSBzeXN0ZW0gb3duZXIgY2FuIGFsc28gdHVybiBTZWN1cmUgQm9vdCBvZmYuDQo+Pj4+IFdp
dGggdGhpcyBjb250cm9sLCB0aGV5IG1heSB1c2UgaW5zZXJ0LXN5cy1jZXJ0IHRvIGluY2x1ZGUg
dGhlaXIgb3duIGtleSANCj4+Pj4gYW5kIHJlLXNpZ24gdGhlaXIga2VybmVsIGFuZCBoYXZlIGl0
IGJvb3QuICBUaGUgc3lzdGVtIG93bmVyIGFsc28gaGFzIA0KPj4+PiBjb250cm9sIHRvIGluY2x1
ZGUgb3IgZXhjbHVkZSBNT0sga2V5cy4gVGhpcyBzZXJpZXMgZG9lcyBub3QgdHJ5IHRvIA0KPj4+
PiBpbnRlcnByZXQgaG93IGEgc3lzdGVtIG93bmVyIGhhcyBjb25maWd1cmVkIHRoZWlyIG1hY2hp
bmUuICBJZiB0aGUgc3lzdGVtIA0KPj4+PiBvd25lciBoYXMgdGFrZW4gdGhlIHN0ZXBzIHRvIGFk
ZCB0aGVpciBvd24gTU9LIGtleXMsIHRoZXkgd2lsbCBiZSANCj4+Pj4gaW5jbHVkZWQgaW4gdGhl
IG1hY2hpbmUga2V5cmluZyBhbmQgdXNlZCBmb3IgdmVyaWZpY2F0aW9uLCBleGFjdGx5IA0KPj4+
PiB0aGUgc2FtZSB3YXkgYXMga2V5cyBjb250YWluZWQgaW4gdGhlIGJ1aWx0aW4gYW5kIHNlY29u
ZGFyeSBrZXlyaW5ncy4NCj4+Pj4gU2luY2UgdGhlIHN5c3RlbSBvd25lciBoYXMgdGhlIGFiaWxp
dHkgdG8gYWRkIGtleXMgYmVmb3JlIGJvb3RpbmcgdG8NCj4+Pj4gZWl0aGVyIHRoZSBtYWNoaW5l
IG9yIGJ1aWx0aW4ga2V5cmluZ3MsIGl0IGlzIHZpZXdlZCBhcyBpbmNvbnNlcXVlbnRpYWwgDQo+
Pj4+IGlmIHRoZSBrZXkgb3JpZ2luYXRlZCBmcm9tIG9uZSBvciB0aGUgb3RoZXIuDQo+Pj4+IA0K
Pj4+PiBUaGlzIHNlcmllcyBpbnRyb2R1Y2VzIHR3byBkaWZmZXJlbnQgd2F5cyB0byBjb25maWd1
cmUgdGhlIG1hY2hpbmUga2V5cmluZy4NCj4+Pj4gQnkgZGVmYXVsdCwgbm90aGluZyBjaGFuZ2Vz
IGFuZCBhbGwgTU9LIGtleXMgYXJlIGxvYWRlZCBpbnRvIGl0LiAgV2hlbmV2ZXINCj4+Pj4gYSBD
QSBjZXJ0IGlzIGZvdW5kIHdpdGhpbiB0aGUgbWFjaGluZSwgYnVpbHRpbiwgb3Igc2Vjb25kYXJ5
LCBhIGZsYWcgDQo+Pj4+IGluZGljYXRpbmcgdGhpcyBpcyBzdG9yZWQgaW4gdGhlIHB1YmxpYyBr
ZXkgc3RydWN0LiAgVGhlIG90aGVyIG9wdGlvbiBpcyANCj4+Pj4gaWYgdGhlIG5ldyBLY29uZmln
IElOVEVHUklUWV9DQV9NQUNISU5FX0tFWVJJTkcgaXMgZW5hYmxlZCwgb25seSBDQSBjZXJ0cyAN
Cj4+Pj4gd2lsbCBiZSBsb2FkZWQgaW50byB0aGUgbWFjaGluZSBrZXlyaW5nLiBBbGwgcmVtYWlu
aW5nIE1PSyBrZXlzIHdpbGwgYmUgDQo+Pj4+IGxvYWRlZCBpbnRvIHRoZSBwbGF0Zm9ybSBrZXly
aW5nLg0KPj4+PiANCj4+Pj4gQSBDQSBjZXJ0IHNoYWxsIGJlIGRlZmluZWQgYXMgYW55IFg1MDkg
Y2VydGlmaWNhdGUgdGhhdCBjb250YWlucyB0aGUgDQo+Pj4+IGtleUNlcnRTaWduIGtleSB1c2Fn
ZSBhbmQgaGFzIHRoZSBDQSBiaXQgc2V0IHRvIHRydWUuDQo+Pj4gDQo+Pj4gSGkgRXJpYywNCj4+
PiANCj4+PiBBbGxvd2luZyBDQSBjZXJ0aWZpY2F0ZXMgd2l0aCB0aGUgZGlnaXRhbFNpZ25hdHVy
ZSBrZXkgdXNhZ2UgZmxhZw0KPj4+IGVuYWJsZWQgZGVmZWF0cyB0aGUgcHVycG9zZSBvZiB0aGUg
bmV3IEtjb25maWcuICBQbGVhc2UgdXBkYXRlIHRoZQ0KPj4+IGFib3ZlIGRlZmluaXRpb24gdG8g
ZXhjbHVkZSB0aGUgZGlnaXRhbFNpZ25hdHVyZSBrZXkgdXNhZ2UgZmxhZyBhbmQNCj4+PiBtb2Rp
ZnkgdGhlIGNvZGUgYWNjb3JkaW5nbHkuDQo+PiANCj4+IFdpdGhpbiB2MiwgdGhlIHJlcXVlc3Qg
d2FzIG1hZGUgdG8gYWxsb3cgSW50ZXJtZWRpYXRlIENBIGNlcnRpZmljYXRlcyB0byBiZSANCj4+
IGxvYWRlZCBkaXJlY3RseS4gIFRoZSBJbnRlcm1lZGlhdGUgQ0EgcmVmZXJlbmNlZCB3YXMgdGhl
IG9uZSB1c2VkIGJ5IGtlcm5lbC5vcmcuICANCj4+IFRoaXMgSW50ZXJtZWRpYXRlIENBIGNvbnRh
aW5zIGJvdGggZGlnaXRhbFNpZ25hdHVyZSBhbmQga2V5Q2VydFNpZ24uICBJZiB0aGUgY29kZSAN
Cj4+IGlzIGNoYW5nZWQgdG8gZXhjbHVkZSB0aGlzIGNlcnRpZmljYXRlLCBub3cgdGhlIHJvb3Qg
Q0EgaGFzIHRvIGJlIGxvYWRlZCBhZ2Fpbi4gIElzIHRoYXQgDQo+PiB0aGUgaW50ZW50Pw0KPiAN
Cj4gVGhhdCBkZWZpbml0ZWx5IHdhcyBub3QgdGhlIGludGVudC4gIE5vciB3b3VsZCBpdCBhZGRy
ZXNzIHRoZSBpc3N1ZSBvZg0KPiBhIHBhcnRpY3VsYXIgaW50ZXJtZWRpYXRlIENBIGNlcnRpZmlj
YXRlIGhhdmluZyBib3RoIGtleUNlcnRTaWduIGFuZA0KPiBkaWdpdGFsU2lnbmF0dXJlLg0KDQpT
b3JyeSwgSeKAmW0gbm90IGZvbGxvd2luZy4gIFdoeSBpcyBpdCBhbiBpc3N1ZSB0aGF0IGFuIGlu
dGVybWVkaWF0ZSBDQSBjZXJ0aWZpY2F0ZSBjb250YWlucyANCmJvdGgga2V5Q2VydFNpZ24gYW5k
IGRpZ2l0YWxTaWduYXR1cmU/IFdoeSB3b3VsZCB3ZSB3YW50IHRvIGV4Y2x1ZGUgYW4gSW50ZXJt
ZWRpYXRlDQpDQSBjZXJ0IGxpa2UgdGhlIG9uZSB1c2VkIG9uIGtlcm5lbC5vcmc/DQoNCg==
