Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BA15718C1
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Jul 2022 13:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbiGLLlE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Jul 2022 07:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiGLLlA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jul 2022 07:41:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7003FAE3B5;
        Tue, 12 Jul 2022 04:40:59 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CAcQrw010704;
        Tue, 12 Jul 2022 11:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=dhuv8amPU1lpTuX2ldJ7QTJWQ9oLCQAbrXih6G3/CoQ=;
 b=JFo2H1ui6Rp8//87qRRT5By4ovEmOzdU9Z8giCHuBcKIeR3fHRaxbWBMxE7MWF6QXCoc
 vW72Z7aIc9Ywm8H9rIkfuN4PR79DSMWLYEV6zXgr0NOHdqa3NCPCT3ArGYtfUR5hMIzt
 YWFWE6Xm8c44yyo144Y2nxlHWIIq5TqWC5OxO5eWYs/fRHqwwNtcS1l4PeYJgcZ+PaJW
 YVQ5/Hue4nZ0MEOJlmHiRx41zWmrNw8FicYfLBfI0bGw8sS/XbmcoOUyhhyDp+WEnu3a
 ixcPu7OGLmx7eslRrKySPS4XqVRBFMd3AkYVcIioKHNDxRI4zERYekBYntLIeYAr7SQe 0w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h96qfaex9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 11:40:51 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26CAlMNl012943;
        Tue, 12 Jul 2022 11:40:50 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h96qfaewh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 11:40:50 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26CBa5g7016842;
        Tue, 12 Jul 2022 11:40:48 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3h71a8v3ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 11:40:48 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26CBdHtY23134658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 11:39:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AE94A404D;
        Tue, 12 Jul 2022 11:40:46 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0980EA4040;
        Tue, 12 Jul 2022 11:40:44 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.147.132])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jul 2022 11:40:43 +0000 (GMT)
Message-ID: <e1a3b460fe2d12afd897fc3c378fe86902f5bb57.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: force signature verification when CONFIG_KEXEC_SIG
 is configured
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Coiby Xu <coxu@redhat.com>, linux-integrity@vger.kernel.org
Cc:     kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        Jiri Bohac <jbohac@suse.cz>,
        Matthew Garrett <mjg59@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Date:   Tue, 12 Jul 2022 07:40:43 -0400
In-Reply-To: <20220712093302.49490-1-coxu@redhat.com>
References: <20220712093302.49490-1-coxu@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MpkPlNP-s9Sa8RtSTtN_o1O_-BVg1fUX
X-Proofpoint-GUID: 8apTZIbzd9VOJ2kDjloc8eODXVgG-4vP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_08,2022-07-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1011
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-07-12 at 17:33 +0800, Coiby Xu wrote:
> Currently, an unsigned kernel could be kexec'ed when IMA arch specific
> policy is configured unless lockdown is enabled. Enforce kernel
> signature verification check in the kexec_file_load syscall when IMA
> arch specific policy is configured.
> 
> Fixes: 99d5cadfde2b ("kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG and KEXEC_SIG_FORCE")
> Reported-by: Mimi Zohar <zohar@linux.ibm.com>
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>

Thanks, Coiby.  This patch is now queued in next-integrity/next-
integrity-testing.

Mimi

