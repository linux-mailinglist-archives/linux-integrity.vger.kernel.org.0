Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E66523D37
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 21:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346683AbiEKTNT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 15:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345686AbiEKTNR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 15:13:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC2E7357F;
        Wed, 11 May 2022 12:13:16 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BH1qih030573;
        Wed, 11 May 2022 19:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=7GCQv78viqKU8RwDGBuW3z+HlE0qjI3m9seEq8djQSw=;
 b=JKeXOfhJY31bnB3N8mlZWyQTtVg/2iabjwzDPbV6QJbzNL04pzYx/3Bdlo9B2w97XxXp
 g3cQjjs/DRt0/Cs9VOueuz5z4aJM9qVL82NBVZ+PCjKBv5ER32zRJPBwRvtu+7iJWGNZ
 l2jvlWTZPKISTV8g3kg0xWPCbyO3jJc0q68I4go6DETklymLviOQSJDS2D2F5lHRBvnP
 7ZR5eJAgnTxrBz+RJyBxyzCrOYF9srf2HtXUrV+klNJNJxb3J/PVsYQd/pkPlBcbim5c
 ars20e+3CnQQRSJjZZdrXYNUurz84m546xXo/WTs4PMzB+eFgqyIx9AZGkFHVXQSFrdK ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0cme100e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 19:12:46 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24BIvBrm014399;
        Wed, 11 May 2022 19:12:45 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0cme0yyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 19:12:45 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24BJ7hX2005482;
        Wed, 11 May 2022 19:12:43 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3fwg1hvk4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 19:12:43 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24BJCeuR50790726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 19:12:40 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A346EA405C;
        Wed, 11 May 2022 19:12:40 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF350A4054;
        Wed, 11 May 2022 19:12:38 +0000 (GMT)
Received: from sig-9-65-89-202.ibm.com (unknown [9.65.89.202])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 May 2022 19:12:38 +0000 (GMT)
Message-ID: <997ea6e0a1f2c40f429ad1f457566cdd80458c78.camel@linux.ibm.com>
Subject: Re: [PATCH v3] x86/kexec: Carry forward IMA measurement log on kexec
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jonathan McDowell <noodles@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Date:   Wed, 11 May 2022 15:12:38 -0400
In-Reply-To: <Ynv4zBnLvbMKrwrq@zn.tnic>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
         <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
         <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
         <67f0fe5874638241bc2f2401dc2bc12c51becc0b.camel@linux.ibm.com>
         <Ynv4zBnLvbMKrwrq@zn.tnic>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FMIVkOK8bETfNCXJnG5WCBfstjQsssso
X-Proofpoint-GUID: qv3eKpt49e3w7Y1UmtFq3Qv1l1cZgdY6
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=851 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205110083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-05-11 at 19:56 +0200, Borislav Petkov wrote:
> On Wed, May 11, 2022 at 01:53:23PM -0400, Mimi Zohar wrote:
> > This patch doesn't apply to Linus' master branch.  Which tip/master
> > branch?
> 
> This one:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/

thanks!

> 
> Considering how the majority of the changes are x86-specific, I was
> thinking I'd carry it through the tip tree after getting your ACK for
> the IMA side of things?

Agreed, all of the changes should be architecture specific.  It should
definitely be upstreamed via x86.

thanks,

Mimi

