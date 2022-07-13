Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BA55738B6
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Jul 2022 16:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbiGMOYL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Jul 2022 10:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiGMOYI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jul 2022 10:24:08 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E048023160;
        Wed, 13 Jul 2022 07:24:07 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DEEgor004515;
        Wed, 13 Jul 2022 14:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Kqd8S3YsVTupeYDsw/0CEjgSPyDSJBms6hyW9oBAQeM=;
 b=QswoJDCWPAwTxoZHbdQEOYKJFNMNTb2KFlnGbq7oimxzEtYekgdpSiRH/HNBsveUdi/f
 1c4OgdZzQ7WLvfp5Gh+2GZ/LXRW8hApTxw75mJZhcsPDNNgnlyJ+Z89sKRqwNHEooqX+
 czJ8NIQEa4koGb3HjCFShmMwZeEIocw9bWmvbkNOizW6cHrfWrta+3DFONOUT42z6MFV
 u9nj5WHC2ENWupHa+kNzIwpjhdmcuVdSiuKRm7clv7Lfh9eh9b1idBzuyd7gxRNzD9hg
 pQELC3clUGyVOLTRv8+FgiKBwKBoqzTxWvwdIrSC7/cs8xZ0bppXs2d8s5idEtkUeH9E Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9ymvratk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 14:23:45 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26DEFSXF013891;
        Wed, 13 Jul 2022 14:23:44 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9ymvrasc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 14:23:44 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26DEKPjp000304;
        Wed, 13 Jul 2022 14:23:42 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3h71a8w2sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 14:23:41 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26DENdG921365098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 14:23:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4C5D52051;
        Wed, 13 Jul 2022 14:23:39 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.111.228])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 883BE5204F;
        Wed, 13 Jul 2022 14:23:36 +0000 (GMT)
Message-ID: <8bea9e61be96e0358a43e320f9b89b742e8ca992.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima: force signature verification when
 CONFIG_KEXEC_SIG is configured
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Coiby Xu <coxu@redhat.com>, linux-integrity@vger.kernel.org
Cc:     kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Date:   Wed, 13 Jul 2022 10:23:35 -0400
In-Reply-To: <20220713072111.230333-1-coxu@redhat.com>
References: <20220712093302.49490-1-coxu@redhat.com>
         <20220713072111.230333-1-coxu@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fr7HlAMLzOgY2q57u1UJRu5T-WiUxJYG
X-Proofpoint-ORIG-GUID: FClJBHTbZacQzfCFbUO4Cd14E0SRbUrp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-13_03,2022-07-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207130055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-07-13 at 15:21 +0800, Coiby Xu wrote:
> Currently, an unsigned kernel could be kexec'ed when IMA arch specific
> policy is configured unless lockdown is enabled. Enforce kernel
> signature verification check in the kexec_file_load syscall when IMA
> arch specific policy is configured.
> 
> Fixes: 99d5cadfde2b ("kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG and KEXEC_SIG_FORCE")
> Reported-by: Mimi Zohar <zohar@linux.ibm.com>
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
> v2
>  - don't include linux/kexec.h since it's already been included in
>    linux/ima.h
>  - fix build errors when KEXEC_FILE/KEXEC_CORE is disable as caught by
>    kernel test robot <lkp@intel.com>

Thanks, Coiby.  This version of the patch is now queued in next-
integrity/next-
integrity-testing.

Mimi

