Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A077D9CBF
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Oct 2023 17:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346294AbjJ0PSa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Oct 2023 11:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346292AbjJ0PSa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Oct 2023 11:18:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA5493
        for <linux-integrity@vger.kernel.org>; Fri, 27 Oct 2023 08:18:28 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39REeF8t005240;
        Fri, 27 Oct 2023 15:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=j+mMvmVLqP//C/WzzEGdX0fdXKaCzyVufQlDMY29gEk=;
 b=js3119UVKLdHyNEwpfDMZTeNKCErCE/16U1fGvpfGqf07ddMOvokL6Z/HHchVqcDm/Tb
 3YzWZFi+uL8zD3VJHDwNiaiGyvnAoWHGtqM763scKdFwCvpU+Bo/2peAv7AE5goVtyhn
 +9P0Fm0pVcePEgFqjT0HtF4ODH6Ddu5VfaHTMwVgRmniR9wWrRVukiwUVu70zZ8epxOE
 Ej6sLe1zWZgSl0FSrbEFz14+CsCEaXsIy8EsNxuBm2QtaeG1tV+Z8uXVgBMlEOTTtRgl
 gMB0eHVh7MBSvT4vUNbymk1XLlxQqhWIUs8Aw0zOK9f6OZnEcxUyBC4JbNOMkjgp4Zsz 5g== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u0f61h1xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 15:18:13 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDFETm026812;
        Fri, 27 Oct 2023 15:18:12 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tywqrnvtc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 15:18:12 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39RFIB3h31785340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 15:18:12 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D44B65805D;
        Fri, 27 Oct 2023 15:18:11 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5339058043;
        Fri, 27 Oct 2023 15:18:11 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.185.59])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Oct 2023 15:18:11 +0000 (GMT)
Message-ID: <8f87e7e4fe5c5a24cdc0d3e2267eeaf00825d1bb.camel@linux.ibm.com>
Subject: Re: [PATCH v2 0/7] ima: kexec: measure events between kexec load
 and execute
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date:   Fri, 27 Oct 2023 11:18:10 -0400
In-Reply-To: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PcTYPCrPXOTP7XH_VGGWu_ql3-oXFaBO
X-Proofpoint-GUID: PcTYPCrPXOTP7XH_VGGWu_ql3-oXFaBO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270131
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-10-05 at 11:25 -0700, Tushar Sugandhi wrote:
> The current Kernel behavior is IMA measurements snapshot is taken at
> kexec 'load' and not at kexec 'execute'.  IMA log is then carried
> over to the new Kernel after kexec 'execute'.
> 
> Some systems can be configured to call kexec 'load' first, and followed
> by kexec 'execute' after some time.  (as opposed to calling 'load' and
> 'execute' in one single kexec command).

Additional measurements may be introduced by the kexec load itself. 
Saving the measurement list as close as possible to the reboot is
beneficial, whether or not the kexec load and kexec execute are
executed separately.

> In such scenario, if new IMA
> measurements are added between kexec 'load' and kexec 'execute', the
> TPM PCRs are extended with the IMA events between 'load' and 'execute'.
> But those IMA events are not carried over to the new Kernel after kexec
> soft reboot.  This results in mismatch between TPM PCR quotes, and the
> actual IMA measurements list, after the system boots into the new kexec
> image.  This mismatch results in the remote attestation failing for that
> system.
> 
> This patch series proposes a solution to solve this problem by allocating
> the necessary buffer at kexec 'load' time, and populating the buffer
> with the IMA measurements at kexec 'execute' time. 

How about beginning the paragraph with "To solve this problem allocate
... and populate ..."

-- 
thanks,

Mimi

