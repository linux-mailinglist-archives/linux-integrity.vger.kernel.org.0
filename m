Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287C07D995D
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Oct 2023 15:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345523AbjJ0NJc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Oct 2023 09:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345458AbjJ0NJc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Oct 2023 09:09:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE8C128
        for <linux-integrity@vger.kernel.org>; Fri, 27 Oct 2023 06:09:30 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RD7Ks8010730;
        Fri, 27 Oct 2023 13:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=cfXXdl2mmSL1JvewQ+xDOdBh+9Ip9UyDBs9c0+yLOQc=;
 b=nA6eQgqjnN+mYycRbxuWhCBp3JZy1QCcq/ijH/gDjsHdc5sGcjsZ0n1MhWMFvp6JPNVk
 6H1hFJCFf9hS/2rh3z/uA1GTJ8QeIPPDyP4BhYv42vLZ0tDorb9WYSbGc7AwqYXQJqvK
 IPKDiSi84IFlGGP8D/kLOevFmg+try5pPme7VjtS8gkJ81OrUFR4D9fMpHqwmbcickAu
 2YmSwLar+rmB//YaIwty2uRXcOX7D6v+vowmRKzI5axDS8YRUB/lEuXZuGKSMtA+A718
 PS0yMN/Ix4XbgQpwk5IctCBTousDuEiWEHp/FOcZhgr8h2S6KeEQp9CLDEaDegS8Zs4a zw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u0dteg4qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 13:09:07 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39RAP3uu021533;
        Fri, 27 Oct 2023 13:08:59 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tywqrd71j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 13:08:59 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39RD8w3G53870860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 13:08:59 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDA9B58061;
        Fri, 27 Oct 2023 13:08:58 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C7F558060;
        Fri, 27 Oct 2023 13:08:58 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.185.59])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Oct 2023 13:08:58 +0000 (GMT)
Message-ID: <989af3e9a8621f57643b67b717d9a39fdb2ffe24.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/7] ima: move ima_dump_measurement_list call from
 kexec load to execute
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date:   Fri, 27 Oct 2023 09:08:57 -0400
In-Reply-To: <20231005182602.634615-3-tusharsu@linux.microsoft.com>
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
         <20231005182602.634615-3-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y3a8pRECF_hLWnaizIrcj3S67b_ZA_J6
X-Proofpoint-ORIG-GUID: y3a8pRECF_hLWnaizIrcj3S67b_ZA_J6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_11,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1015 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

On Thu, 2023-10-05 at 11:25 -0700, Tushar Sugandhi wrote:
> In the current IMA implementation, ima_dump_measurement_list() is called
> during the kexec 'load' operation.  This can result in loss of IMA
> measurements taken between the 'load' and 'execute' phases when the
> system goes through Kexec soft reboot to a new Kernel.  The call to the
> function ima_dump_measurement_list() needs to be moved out of the
> function ima_add_kexec_buffer() and needs to be called during the kexec
> 'execute' operation.
> 
> Implement a function ima_update_kexec_buffer() that is called during
> kexec 'execute', allowing IMA to update the measurement list with the
> events between kexec 'load' and 'execute'.  Move the 
> ima_dump_measurement_list() call from ima_add_kexec_buffer() to
> ima_update_kexec_buffer().  Make ima_kexec_buffer and kexec_segment_size
> variables global, so that they can be accessed during both kexec 'load'
> and 'execute'.  Add functions ima_measurements_suspend() and
> ima_measurements_resume() to set and reset the 'suspend_ima_measurements'
> variable respectively, to suspend/resume IMA measurements.  Use
> the existing 'ima_extend_list_mutex' to ensure that the operations are
> thread-safe.  These function calls will help maintaining the integrity
> of the IMA log while it is being copied to the new Kernel's buffer.
> Add a reboot notifier_block 'update_buffer_nb' to ensure
> the function ima_update_kexec_buffer() gets called during kexec
> soft-reboot.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>

The lengthiness and complexity of the patch description is an
indication that the patch  needs to be broken up.  Please refer to
Documentation/process/submitting-patches.rst  for further info.

In addition, this patch moves the function ima_dump_measurement_list()
to a new function named ima_update_kexec_buffer(), which is never
called.   The patch set is thus not bisect safe.

[...]
> +void ima_measurements_suspend(void)
> +{
> +	mutex_lock(&ima_extend_list_mutex);
> +	atomic_set(&suspend_ima_measurements, 1);
> +	mutex_unlock(&ima_extend_list_mutex);
> +}
> +
> +void ima_measurements_resume(void)
> +{
> +	mutex_lock(&ima_extend_list_mutex);
> +	atomic_set(&suspend_ima_measurements, 0);
> +	mutex_unlock(&ima_extend_list_mutex);
> +}

These function are being defined and called here, but are not enforced
until a later patch.   It would make more sense to introduce and
enforce these functions in a single patch with an explanation as to why
suspend/resume is needed.

The cover letter describes the problem as "... new IMA measurements are
added between kexec 'load' and kexec 'execute'".    Please include in
the patch description the reason for needing suspend/resume, since
saving the measurement records is done during kexec execute.

-- 
thanks,

Mimi

