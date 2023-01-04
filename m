Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F8565DF44
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Jan 2023 22:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbjADVr0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Jan 2023 16:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240451AbjADVq4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Jan 2023 16:46:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AEB1007B;
        Wed,  4 Jan 2023 13:46:55 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304FO0DU029542;
        Wed, 4 Jan 2023 21:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5ZJXo4H7SpqEJnDLzyEWQgyt25GmyD8R+SoCfeq2jc4=;
 b=bvOpZtu37RxSougxqvul43OtPpTFNYgiejIHcph4iROjEGNJ8KC+OPwdoPkwFi/4kWgw
 Gong1l3fvby1D0Bx+3VdcwKMaEzW5sC1JKkeAZHQfWpEeMYhXUL7gt1nOAbUltCRqEVh
 62j8aTGjiVW6VRntHaNPBd6BOeFSBM2wKhxBdsQII+PK80c/yE825s9LD6ScebMbKEms
 f63KopAXcf6Znin/qNYb+BoT7l8q/jZuuLshjAqPJ7cjYdVOTBNhkQ6BDRAAI3i1JxXU
 cpE9HCqJpfAA7MmS/57dioDAYZO53J4QiUW0xUHeEP7p6ewNxPfehPqj1VvWaf0TXDcY pQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbv2ynpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jan 2023 21:46:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 304JwSbk031402;
        Wed, 4 Jan 2023 21:46:27 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwg373cfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jan 2023 21:46:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNauVPvghUIOb4W9lSo4T/xMkZj57Rn0Mrua5LuDGEx8doVL7vA7jtTmaZFMf0mE+jkPHkYyhqQEFjn8MndQq56swWlXSmXrjgibUAnGS3OMSuvLqrMI2i5y2jqqOYDgTkQPMjoN9DCYSTxbHU+5nmXYNdrE+qrKrH37rneeoeQTZWUQULpE47nXmyq/QGJPz2o69gksRnyx4Hg1QTOT8IvRknZOVFQKdV4f9cnTHu3IKA4aPhbzoljjlb85X3aX21VGGYqJGSwdhcnGNV8lKepUSsViAttH2SehfHUARFalKhVS0WUOcLzWh7SYuAUFN5eIOqYNkw0NefIT02QYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZJXo4H7SpqEJnDLzyEWQgyt25GmyD8R+SoCfeq2jc4=;
 b=IMgX4CsQ6/9RkAOO5NigUs/pzzODO3/G/nffJ8S1K4BXQoWvHWjqU7QJDSDmJK2QWNWancrAnuvLzuk4VqmuhRwfeFN/9Vj2E4Agn7rd/0WL4fUts5stMmm69Vy+p3iwMP2/FdGiTZBPPxY5KhS3jtjYEGJLtSUASI4B5Qq0vIg8JnHMh7ToQ7Tr9KtOOKgv2o9uabtkk5SrK6g2Qq+G/LGw1m3SMz0ghUV0wq8hOsNuY29EPczkdTYLy/S4mqakB8clME/f3siGqZPKOzRmYeVsqVErlGyYq9SQNUgBNpAYucbtCFRIHn1gbvD0Ln+UAFIgCbksbwhv/520msiM5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZJXo4H7SpqEJnDLzyEWQgyt25GmyD8R+SoCfeq2jc4=;
 b=Fm0MRQt4tysBF5fACTayjVKFM+Ui7FVMZi5KvXgnCjRmv0eWUI/Yzd1xhBScEL/nTvxgfjpSQWUP2U+JKHJFaEXAB3iQFS+CZ8QxjTrFhFV+5oRvojkFfcpvr2Xmtmvas7NeVTDW4ZyczLtDXnF36LUkkh6Bh4de6POfWk1KfYo=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CY8PR10MB6825.namprd10.prod.outlook.com (2603:10b6:930:9c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 21:46:25 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 21:46:24 +0000
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
Subject: Re: [PATCH v3 04/10] KEYS: X.509: Parse Key Usage
Thread-Topic: [PATCH v3 04/10] KEYS: X.509: Parse Key Usage
Thread-Index: AQHZD1PG9Fvwp9tx9E+Z56w5iMLq6a6ORP8AgACoVAA=
Date:   Wed, 4 Jan 2023 21:46:24 +0000
Message-ID: <B90D2183-4712-4E01-9986-52CB51F968DF@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
 <20221214003401.4086781-5-eric.snowberg@oracle.com>
 <Y7VmfLUAacYOjn9y@kernel.org>
In-Reply-To: <Y7VmfLUAacYOjn9y@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|CY8PR10MB6825:EE_
x-ms-office365-filtering-correlation-id: bf4f5440-d953-41d7-b0e1-08daee9d2084
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Ysn/Jg5O5LE3UpjTEhonj4JOoto0Rh3+BKndD4yo3VWnA5FFtyRzk2ty9p5jBqtkQ0rGbsnmEAmrMRsm2SUd4Owkfh8YZlJkz7mthVLRLfquC91ComqRY9U5WmgdwYDxcIG+XDW2A3pmhST9rAjYqJWb0mDcYRAJZQretDc0lKrN1Z5paLS1a1/AI3FIf3H1nlKO21k/7ZZLVQHFRVWugHdFUiGmtkTR/ujywbZUVgIB9Tp172eYrbTzF3ocFriwo57rGw87/V7FouPOEMC8vp9DrDV+ryywKuQf+1xuPQeqZ1g0LVVejejZukkw0ovKf+QYsI18qwvowOrvFRdprJhO7f9kR7sZFUsmZtkyFR5fYLDktwXxL0YXcrp/8tHMSAyFVXd/nmprcKYKt5IzxZRK3hzJplgohOb7dLS6V/VEN6gDJ4CGxC/v3CfzDLleVLN8ONdjI+I4MHWeNlpafHCwsDCYpMiZTOa/mOccO2P4ZGZBXQ9dCL9iYaHpwTWRClZnXBhgQqEeLleqyW8FiR70sq0RKDEcKIW81NA13YkGOfsCL1jFeoPQfJDnRiz0euNXnzwAtdCRHUBiEg9rfpZRQtw39h0xh42Ypo3XH15yde3UnUABEfrsyX5CzGAeMRUcZcTfW3f+O72y5+Hiv4YJDkM/7/44/OR9/3qG4FgHdhJ2Sf8fB+Yli+nySBD1g7xouYfSe7tI5T53/mqvvED61SUzuG7mJTNFIhzXtk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199015)(6506007)(54906003)(7416002)(66946007)(316002)(6512007)(76116006)(53546011)(186003)(2906002)(91956017)(4326008)(5660300002)(44832011)(71200400001)(6486002)(478600001)(41300700001)(26005)(86362001)(6916009)(83380400001)(2616005)(64756008)(66446008)(8676002)(38100700002)(36756003)(38070700005)(8936002)(122000001)(33656002)(66556008)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MRSD1WBci5Nm5DMCGVbgl6pGn/0PMvK3NZNhO8qp1SQZdGaon+oCFv7uy8NF?=
 =?us-ascii?Q?9hBQFdbP62ACWG25fs5uZT8EAAx8Sx2x8B4X5xj5AOI5V3vLzvC8dE6AeUhw?=
 =?us-ascii?Q?LMRUjJ9W6wfxGURpjuq+6VEJgCUN6vmMGTKwx7iUcXM2eMD/eNjz4LlbPrAw?=
 =?us-ascii?Q?9+YPdVSqVq/fRdtvINxIDyYKx5NB61wG5mKdZcv2YNerz6xfCgYjEgCdeRr+?=
 =?us-ascii?Q?3rffIwzV+8GdtmohFHIlJiqH+OFpEsUxNFuud1SJE1bBCWfnuiSMG0BsK1uc?=
 =?us-ascii?Q?o+huZcFlt/Pceicb/jPvIdnzQLtdNFsXsdanCCwdgm5EzpB6dfGAsqg57wRs?=
 =?us-ascii?Q?B8otev1i86s5NK5uDmMinvYHMqmpZOI1kDDckn3/FQAK///fHdgAxHH1W0Ht?=
 =?us-ascii?Q?HxvSnaYtZxgFw8YqrpjN8gYuL03FEbJVQiu6TsT/LvT/6IkBYekEQ/cDVphb?=
 =?us-ascii?Q?EcUuxg4F+TxbWVS5pgsuAuCSvNw7XNFOGMbz5jNYNkri4C0HsgVLMhcSnfnq?=
 =?us-ascii?Q?GDKfqKwxUqJaT6BRS9SvQ5bozqTG3ISL3lRpP7acgUoF24Tm7EGeZyKsB6FZ?=
 =?us-ascii?Q?eGdJJKFfZRQ5uhDddvqqBh5VUdhlVVqtWEHqSo8YaVwG77Eg8+S9+X+ghHWQ?=
 =?us-ascii?Q?hQ6K8CJiHAZv+wS6ZOFM6Bv7MGUppjPWmlUoXfYTgqkFkfguD/GEgV8bH1AF?=
 =?us-ascii?Q?zuyvqf5/OtodvizI0ziilwTRFKj64hXJPgl1jmwOXTlovHoodXmJmTUJXRIQ?=
 =?us-ascii?Q?RVuuvpJrBDThZLSjHbRQdgBV73DR/IYp0WyDF9wUFX3Dp8TSJJ+UkDIra6I6?=
 =?us-ascii?Q?DOE/8muspMfE/h09TYEXEbK67z0gX2CO+uAC6TpPa61+7Blb21fliNJq69y3?=
 =?us-ascii?Q?axqiKOJ5nRKLxGBe1r5Db+dZm7GRq4Ityd9q9i9CY4kzFuIDDDDrlyFIAtEp?=
 =?us-ascii?Q?Qoi2fXhRsOM/YaFRD202X9NvgeRuC06zhaAXZbvMQs7NWlzH21heV7ZbbJqF?=
 =?us-ascii?Q?6AFMNP9VZhe6i27YjceUAqT07qhVwOaOWh/7Y0ewzefHD1+/rMIO3wASG/QP?=
 =?us-ascii?Q?wHRNpa7v1jdbncL+XPHBzRTNDwAs3ola2+Q3Vg3rxp8W/bnd9xmIa2nEMfBv?=
 =?us-ascii?Q?WX6/SqneZVODafo/mQsxnawK/LWqKFAmZbeSszF3khBffaOLTkXTO1VYchvE?=
 =?us-ascii?Q?fxub3W36Ji5Je1PWlnHbX76B3wX9qaSMuyixDdDZ3rnGVAuU75EFbpKOgQLI?=
 =?us-ascii?Q?o3SEuMY07NBNMGNyZIpB1zsflqEzWS0fGmtyB7y9cThpCOT5D0EOWej30bVY?=
 =?us-ascii?Q?dB1iO92iOU4UQIr/qqrMou7KjHYLz7Va4+7wsza8zJafCtlMSEcUAYeaTg9r?=
 =?us-ascii?Q?C3fCU7X/aa1SpGbswyXZR8HPHbWAO9M/CzQVVqJNBMac/ON40aQ52KZ4+/M7?=
 =?us-ascii?Q?D0Wp1qtI/9hQuXm/gQlpRT95fr+zTjcUQWafT90kBay3pkqoaubOeIiesYHC?=
 =?us-ascii?Q?dZtNj5Cg9DKTk52A/20im/zbUZXYKQM4zsmeIIF0mdNSEIvKmbjk7Po/HSQ+?=
 =?us-ascii?Q?gOxm+C6xTu8gDbOYAMHvrZct2wJFPW9jOQ5JuBkjwUIDNLjCyc8Eikr81AVI?=
 =?us-ascii?Q?/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0B47A83792A5BB4695EDA22FAAF0FA09@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?HSBcO98mbFXNz5x2Fz+4BN3McKUc4DiNKB7622OabRViTftbY6IFx6c6xuAP?=
 =?us-ascii?Q?T1GWgfQNae23PHqEg1BASwf9Xp2Tt18SslfVa+uUKeJoSE2recH+KSA9v54p?=
 =?us-ascii?Q?9Ih1yCAkzd3UP+8M7YN/o+2dz5jXwRxkmuWpP40WQUnvFlqSXbpLflDR2Z9n?=
 =?us-ascii?Q?cS3uRj+Ke6xEgpj4VKn9RzI2hmzKaXvE9po7sd0myK9WUg+KdFIlfTHN2Aoh?=
 =?us-ascii?Q?ucwtirlyI4qzL78726GwAsMnOL8+kc6cT12aNmVR0hniCUwUSk/m/XVWev+2?=
 =?us-ascii?Q?Hrc2hdsXlad5p+CYydU3L9Is4YZRJgJP9Mz3CFnQnfgOpDLWIQGbDhQjvNjO?=
 =?us-ascii?Q?zr5tiJGDDL8fMnOf3228nA3GP1YWPzzKsKUQHNSOJH0hK/4PZ9O0JHTcqOVX?=
 =?us-ascii?Q?tji/Xc1CzKSSg9Y/BSq734aR91y5x81JAAp7yIZ3XzGcdqsF2m6Vy202ILvS?=
 =?us-ascii?Q?gduX2tquBpdp4WXBit/v80/FvD5b8nHHT7+FTGvXrQk6Lvrrz7N5FGMGdsj4?=
 =?us-ascii?Q?0P4V2kPkOdJ8dtNoODJ9v5GynZnUIanPX+/iFEMLMs6gZwvPkvjEsZLWisxH?=
 =?us-ascii?Q?5Y31TlTQBa+dHEDhndaMSunzeP2If815nrHS1MI8+wGA96z25Cp6rrc09ZfD?=
 =?us-ascii?Q?anQBZMm9V+5bAiO7HINRv+9NIxBn5cO45oyMAvgvmXP6agBJIWPxa1wcdReq?=
 =?us-ascii?Q?5wVvA6dK63JkZOkPDJVtUN9pQkpn6xd4IJEgP68lklNvcmBESI1TW63+qiiz?=
 =?us-ascii?Q?tD0jXg/7lt4Oy/plFx1Aya0bSCUq2ctpNui8rK80wTALbFfTPXMR5/c9BJJ9?=
 =?us-ascii?Q?6hWcEhShXkIEJPwXBbIo6Ip7xtcbcsYB1YTWN8yr8VEudDOWdUAQDBd9FvyD?=
 =?us-ascii?Q?ZF8EysMRlzQoghI+aO4XNuLjYsYoF+4+yk/g+tZwo5gX6YOdL8GwKYpJPxN4?=
 =?us-ascii?Q?QCro9Qz7gO2gIWFgGpHFv1teb3Ak+PMIggRi+ye8rj6EWVL+yr5PpNr1Hz+m?=
 =?us-ascii?Q?B2cm3OD03eT+3V6KLYdP0Hu6oKqNTo3t4df5HVIFqOwRgV3Wk1UJcczQ4Q++?=
 =?us-ascii?Q?+xcLHwQ4eJ+XzyEZK/djHlYpmbG6MX5R4EbYVl03r4bvoB9hegOkrDTr7EWB?=
 =?us-ascii?Q?vFyllDF3jfY2LxXvmJN5ShqAu+NjUw2PnExv3coGsltPmC/mw/5v5qRfLCdI?=
 =?us-ascii?Q?HT0s0mxNIXxu3ER4khaVQpWTUGVFPQCIZEbxfl+r7j/K6ZTx6fltp/DeNfpw?=
 =?us-ascii?Q?klAg0llSWAcFp3eEttwYNIp37GYr3xSilaQCF8RLrr6OwaZlGyBLLyB51+IK?=
 =?us-ascii?Q?zvQRv8XjltHNtTjW599E4N7+u7J2BEUkUhXWgeRpNYFOhnSnsB3/i55HH53J?=
 =?us-ascii?Q?y/IomGxfFVp75yO+StWGAkkJsTHDR5wdF7Z9wPsKhuUDEHs3NA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4f5440-d953-41d7-b0e1-08daee9d2084
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 21:46:24.8720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U45/ElQp3YtnyW2rA5qsRjriddlEcsRzLS1AArcGogl9Ft/658OXrWG5Zd1fCa2Bm1HEC71SMfUUHEF+avCWMbJHXqk6IWbYOglbIBr+8dw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301040176
X-Proofpoint-GUID: d1-jrj9vXEmu2lDL62DQZV7C8A8s6ESz
X-Proofpoint-ORIG-GUID: d1-jrj9vXEmu2lDL62DQZV7C8A8s6ESz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> On Jan 4, 2023, at 4:43 AM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Tue, Dec 13, 2022 at 07:33:55PM -0500, Eric Snowberg wrote:
>> Parse the X.509 Key Usage.  The key usage extension defines the purpose =
of
>> the key contained in the certificate.
>>=20
>>   id-ce-keyUsage OBJECT IDENTIFIER ::=3D  { id-ce 15 }
>>=20
>>      KeyUsage ::=3D BIT STRING {
>>           digitalSignature        (0),
>>           contentCommitment       (1),
>>           keyEncipherment         (2),
>>           dataEncipherment        (3),
>>           keyAgreement            (4),
>>           keyCertSign             (5),
>>           cRLSign                 (6),
>>           encipherOnly            (7),
>>           decipherOnly            (8) }
>>=20
>> If the keyCertSign is set, store it in the x509_certificate structure.
>> This will be used in a follow on patch that requires knowing the
>> certificate key usage type.
>>=20
>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
>> ---
>> crypto/asymmetric_keys/x509_cert_parser.c | 22 ++++++++++++++++++++++
>> crypto/asymmetric_keys/x509_parser.h      |  1 +
>> 2 files changed, 23 insertions(+)
>>=20
>> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetr=
ic_keys/x509_cert_parser.c
>> index b4443e507153..edb22cf04eed 100644
>> --- a/crypto/asymmetric_keys/x509_cert_parser.c
>> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
>> @@ -579,6 +579,28 @@ int x509_process_extension(void *context, size_t hd=
rlen,
>> 		return 0;
>> 	}
>>=20
>> +	if (ctx->last_oid =3D=3D OID_keyUsage) {
>> +		/*
>> +		 * Get hold of the keyUsage bit string to validate keyCertSign
>> +		 * v[1] is the encoding size
>> +		 *       (Expect either 0x02 or 0x03, making it 1 or 2 bytes)
>> +		 * v[2] is the number of unused bits in the bit string
>> +		 *       (If >=3D 3 keyCertSign is missing)
>> +		 * v[3] and possibly v[4] contain the bit string
>> +		 * 0x04 is where KeyCertSign lands in this bit string (from
>> +		 *      RFC 5280 4.2.1.3)
>> +		 */
>> +		if (v[0] !=3D ASN1_BTS)
>> +			return -EBADMSG;
>> +		if (vlen < 4)
>> +			return -EBADMSG;
>> +		if (v[1] =3D=3D 0x02 && v[2] <=3D 2 && (v[3] & 0x04))
>> +			ctx->cert->kcs_set =3D true;
>> +		else if (vlen > 4 && v[1] =3D=3D 0x03 && (v[3] & 0x04))
>> +			ctx->cert->kcs_set =3D true;
>> +		return 0;
>=20
> This is much more easier to follow thanks to explanation.
>=20
>> +	}
>> +
>> 	if (ctx->last_oid =3D=3D OID_authorityKeyIdentifier) {
>> 		/* Get hold of the CA key fingerprint */
>> 		ctx->raw_akid =3D v;
>> diff --git a/crypto/asymmetric_keys/x509_parser.h b/crypto/asymmetric_ke=
ys/x509_parser.h
>> index 7c5c0ad1c22e..74a9f929e400 100644
>> --- a/crypto/asymmetric_keys/x509_parser.h
>> +++ b/crypto/asymmetric_keys/x509_parser.h
>> @@ -39,6 +39,7 @@ struct x509_certificate {
>> 	bool		unsupported_sig;	/* T if signature uses unsupported crypto */
>> 	bool		blacklisted;
>> 	bool		root_ca;		/* T if basic constraints CA is set */
>> +	bool		kcs_set;		/* T if keyCertSign is set */
>> };
>>=20
>> /*
>> --=20
>> 2.27.0
>>=20
>=20
> LGTM but I'll hold with reviewed-by's up until the patch set overally
> looks good to me and I have actually tested it.

Thanks for your review.  I will make all the other changes you brought up w=
ith
the other patches in the next round.

