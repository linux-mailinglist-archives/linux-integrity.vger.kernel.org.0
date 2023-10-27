Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299467DA179
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Oct 2023 21:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjJ0Tv0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Oct 2023 15:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0TvZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Oct 2023 15:51:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432B5AB
        for <linux-integrity@vger.kernel.org>; Fri, 27 Oct 2023 12:51:23 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RJkafs016439;
        Fri, 27 Oct 2023 19:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=kUeMCe/VwUkImubdxVU2hrMfBvkt8rGM3VBqBoPvX9g=;
 b=EUTZNucW9fOpV6StSQ9DxmZYNQtcOOpFwkk1jwSvrOYTBdeWXyKNN/5L4r8ZB64Zt9A7
 9MFrBQUmkCdFfU7EoZ7jRlWAzXwhJZIMalzIZFrzJGIbkWpgjSQDJ5lRYS80D8eo6Qcu
 qIuCnwxvnU38PKY7Aosg2KVDixz6SIWbjbtP/GBg3WzFvzhQQFm7f+eW5yYn6WvWLMTm
 aPhcdQfO94hndi+fMamsbnxwj5uxJNLAjeG81l2KquTW35zbymkHjigbZe3RTKNQPBRg
 PiTtKa2ReY3pt4lL+HKwO8YmmtqFKJXPGxFgT/XS9GV6gS3eKzQKUa9Fx4fUQlwdcab2 WA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u0j2bjnpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 19:51:04 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39RIUXJ7011409;
        Fri, 27 Oct 2023 19:51:02 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tywqr7dbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 19:51:02 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39RJp12L14615062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 19:51:02 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A416458053;
        Fri, 27 Oct 2023 19:51:01 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C863458061;
        Fri, 27 Oct 2023 19:51:00 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.171.13])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Oct 2023 19:51:00 +0000 (GMT)
Message-ID: <348e6e3ebd1c6ee1c85cd12f15591f32bb699fdc.camel@linux.ibm.com>
Subject: Re: [PATCH v2 0/7] ima: kexec: measure events between kexec load
 and execute
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date:   Fri, 27 Oct 2023 15:51:00 -0400
In-Reply-To: <8f87e7e4fe5c5a24cdc0d3e2267eeaf00825d1bb.camel@linux.ibm.com>
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
         <8f87e7e4fe5c5a24cdc0d3e2267eeaf00825d1bb.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BwLqtpmEhvUrN5JtmVt2cVMAOKUHzHIt
X-Proofpoint-ORIG-GUID: BwLqtpmEhvUrN5JtmVt2cVMAOKUHzHIt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_19,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270172
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2023-10-27 at 11:18 -0400, Mimi Zohar wrote:
> On Thu, 2023-10-05 at 11:25 -0700, Tushar Sugandhi wrote:
> > The current Kernel behavior is IMA measurements snapshot is taken at
> > kexec 'load' and not at kexec 'execute'.  IMA log is then carried
> > over to the new Kernel after kexec 'execute'.
> > 
> > Some systems can be configured to call kexec 'load' first, and followed
> > by kexec 'execute' after some time.  (as opposed to calling 'load' and
> > 'execute' in one single kexec command).
> 
> Additional measurements may be introduced by the kexec load itself. 
> Saving the measurement list as close as possible to the reboot is
> beneficial, whether or not the kexec load and kexec execute are
> executed separately.
> 
> > In such scenario, if new IMA
> > measurements are added between kexec 'load' and kexec 'execute', the
> > TPM PCRs are extended with the IMA events between 'load' and 'execute'.
> > But those IMA events are not carried over to the new Kernel after kexec
> > soft reboot.  This results in mismatch between TPM PCR quotes, and the
> > actual IMA measurements list, after the system boots into the new kexec
> > image.  This mismatch results in the remote attestation failing for that
> > system.
> > 
> > This patch series proposes a solution to solve this problem by allocating
> > the necessary buffer at kexec 'load' time, and populating the buffer
> > with the IMA measurements at kexec 'execute' time. 
> 
> How about beginning the paragraph with "To solve this problem allocate
> ... and populate ..."

Does this patch set take into account kexec_calculate_store_digests(),
which is called from kexec_load, and verify_sha256_digest()?
-- 
thanks,

Mimi

