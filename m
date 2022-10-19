Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0524603766
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Oct 2022 03:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJSBIz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Oct 2022 21:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJSBIj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Oct 2022 21:08:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D23BDFC08;
        Tue, 18 Oct 2022 18:08:36 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29J0ud4n015004;
        Wed, 19 Oct 2022 01:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=PTXFKiaqw8WDi1XGVH0av05QNVaP7YEtjK+e1UbuFx4=;
 b=UGYlspng/kc9By85lcBcW+vfvU4Iu2DJdZOce4gMsel9NVX97wQSQrJk0EA3Q6GokX4/
 G7dku1aUznvJ5+8f8TeMcIZvSbgjKWtPO+nP3f2X2d39piPXH5EFsnlDOYldoqr1x5CV
 9Njauod594rriORvUSf5GE93d9pz5cd2WR7QRK8eiks9IU2chjhim7qAo/VxXUMnHnIF
 ZG9lbunPOavISxxp+VQE1sqBDyOM7sECsSejStuBIssSSgM4y420Xfk9v8pv19sriXMR
 d5+Pi6kXUg4nBt+VJgXOLqNNDFMQ7idlzhU21rOFk0061ER4PawgBi/Ky4TGVc/Y0+Hm qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ka7510dc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 01:08:13 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29J10BU1029534;
        Wed, 19 Oct 2022 01:07:57 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ka7510cdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 01:07:57 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29J17AkV008974;
        Wed, 19 Oct 2022 01:07:46 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01wdc.us.ibm.com with ESMTP id 3k9be2axsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 01:07:46 +0000
Received: from smtpav03.dal12v.mail.ibm.com ([9.208.128.129])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29J17igc24380140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 01:07:44 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 221D458060;
        Wed, 19 Oct 2022 01:07:45 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79D745803F;
        Wed, 19 Oct 2022 01:07:44 +0000 (GMT)
Received: from sig-9-65-232-148.ibm.com (unknown [9.65.232.148])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 19 Oct 2022 01:07:44 +0000 (GMT)
Message-ID: <90f8940cff5eeef7917e2b11a07e41b32b207ffa.camel@linux.ibm.com>
Subject: Re: [PATCH v5 2/2] ima: Handle -ESTALE returned by
 ima_filter_rule_match()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Guozihua (Scott)" <guozihua@huawei.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 18 Oct 2022 21:07:44 -0400
In-Reply-To: <2f032b6c-ecf2-5a41-dc38-e6ab0a2d7885@huawei.com>
References: <20220921125804.59490-1-guozihua@huawei.com>
         <20220921125804.59490-3-guozihua@huawei.com>
         <ce948f9e5639345026679b31a818cc12a247ce60.camel@linux.ibm.com>
         <77c9c86b-85a6-aa87-e084-59a70bb47167@huawei.com>
         <f321c638bf5572088a8c5e4d7027c3a797bdd568.camel@linux.ibm.com>
         <7ac3e330-e77c-95d8-7d3b-29e243b57251@huawei.com>
         <5e304b17fe709d2b2f30b991d5ffc4711d27a075.camel@linux.ibm.com>
         <2f032b6c-ecf2-5a41-dc38-e6ab0a2d7885@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y8BArRBy6mkseiO0clCZ7DUsoiSTqqnj
X-Proofpoint-ORIG-GUID: lwyednaTJSdh7rQf1GNl4DHVbsSvMc_Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_10,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011
 phishscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190004
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-10-18 at 16:43 +0800, Guozihua (Scott) wrote:
> On 2022/9/28 22:11, Mimi Zohar wrote:
> > 
> > After reviewing this patch set again, the code looks fine.  The commit
> > message is still a bit off, but I've pushed the patch set out to next-
> > integrity-testing, waiting for some Reviewed-by/Tested-by tags.
> > 
> 
> Hi Mimi,
> 
> How's this patch going? I see Roberto is replying with a Reviewed-by.

I'd really like to see a "Tested-by" tag as well.

Are you able to force the scenario?

-- 
thanks,

Mimi

