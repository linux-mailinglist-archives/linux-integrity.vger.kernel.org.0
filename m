Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE4C617DA9
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 14:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiKCNQO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 09:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKCNQN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 09:16:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7F1F1F;
        Thu,  3 Nov 2022 06:16:12 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3CJrOF005056;
        Thu, 3 Nov 2022 13:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=5BiWml0W36/epJ9s/hIXB/eu7R889PKV9mublijindg=;
 b=Wlx8COzM8y+j8wF7ihwpMJacpA8coK0rNWYz1owg6sWotAsrFVciIMMX4ep3Yx9Htx8a
 wIlslmQXqhJmkIpKyT9RQtjXn+/62kuhatKagdAe4ZIWe4Cuibe7tJsHFIHt4gXPy6gZ
 Q3wm8EiHy0UIYn5F5sW1dHW+x1dY76xrINCmnYw5uZDzHUReo5d8VbV7llEmAbBExyxn
 dbvV4n3F6NK90haWDKFIDpdY0BQ05/FvmA2967QIPmxs/Bjb09Wi3B+idB8A1MfKsTAS
 YYQfbfOKFhLjmOIrzJTrrHOfa9bZwoe27XvADfKtDec8dXrwcPEIae3+P7WlIsNaRtoc HA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmcabmk1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 13:15:48 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A3BQHhf013740;
        Thu, 3 Nov 2022 13:15:48 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmcabmk0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 13:15:48 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A3D6IUd009190;
        Thu, 3 Nov 2022 13:15:47 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01wdc.us.ibm.com with ESMTP id 3kguta1g4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 13:15:47 +0000
Received: from smtpav06.dal12v.mail.ibm.com ([9.208.128.130])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A3DFoII13566474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Nov 2022 13:15:50 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0EEB58059;
        Thu,  3 Nov 2022 13:15:45 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FE9258043;
        Thu,  3 Nov 2022 13:15:45 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.20.100])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  3 Nov 2022 13:15:45 +0000 (GMT)
Message-ID: <30ac558a35a0551f50dc49a834755beb1ab2d593.camel@linux.ibm.com>
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
Date:   Thu, 03 Nov 2022 09:15:45 -0400
In-Reply-To: <b2949b3d-c370-8a41-fe7c-9f175abd4f71@huawei.com>
References: <20220921125804.59490-1-guozihua@huawei.com>
         <20220921125804.59490-3-guozihua@huawei.com>
         <ce948f9e5639345026679b31a818cc12a247ce60.camel@linux.ibm.com>
         <77c9c86b-85a6-aa87-e084-59a70bb47167@huawei.com>
         <f321c638bf5572088a8c5e4d7027c3a797bdd568.camel@linux.ibm.com>
         <7ac3e330-e77c-95d8-7d3b-29e243b57251@huawei.com>
         <5e304b17fe709d2b2f30b991d5ffc4711d27a075.camel@linux.ibm.com>
         <2f032b6c-ecf2-5a41-dc38-e6ab0a2d7885@huawei.com>
         <90f8940cff5eeef7917e2b11a07e41b32b207ffa.camel@linux.ibm.com>
         <38d5fd39-ead2-e954-5901-b35ef6ec96b6@huawei.com>
         <11716411-e143-ab1f-3b1e-d5d35f2a590a@huawei.com>
         <db821df65b7ff7319c657a1de65f5ba903599fc4.camel@linux.ibm.com>
         <b2949b3d-c370-8a41-fe7c-9f175abd4f71@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9fbYlwbjQ-qZXh0tNVJNSEe2T_d9YxcP
X-Proofpoint-GUID: qBUTZEitKLwm9gMfCWW755ZDnQb9DiMp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 impostorscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-11-02 at 09:42 +0800, Guozihua (Scott) wrote:
> > As I only see an IMA measurement policy rule being loaded for
> > "unlabeled_t" and not "user_home_t", should I assume that an IMA
> > measurement rule already exists for "user_home_t"?
> 
> There wasn't a rule for user_home_t. These scripts demonstrate that 
> during a selinux policy reload, IMA would measure files that is not in 
> the range of it's LSM based rules. Which is the issue I am trying to fix.
> 
> In this test, we only have one rule for measuring files of type 
> unlabeled_t. However, during selinux policy reload, file of user_home_t 
> is also measured.

Thanks, Scott.  After tweaking the scripts for my system, I was able to
reproduce the bug.  This patch set is now queued in next-integrity.

-- 
thanks, 

Mimi

