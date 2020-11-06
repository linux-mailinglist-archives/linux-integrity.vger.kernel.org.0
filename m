Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03ADC2A98C4
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Nov 2020 16:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgKFPrn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Nov 2020 10:47:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726422AbgKFPrm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Nov 2020 10:47:42 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6FWFiK060479;
        Fri, 6 Nov 2020 10:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=i/mO9hbrdCyvdmpovAZT52QS7fXgEwcehQ/MaulYZ0Q=;
 b=tI2R87hEhoeCIqDbkcvhD18hkchg0df3KIva2ELC5i0w5YaYAhxohu8I12wrRGd01yw6
 kFIeiYwL+37+ogen9iGwb3XNEm2p9qTADVsQ14adAgBVZEZASov/eHLBLS5qSFkEyd8V
 a75mrmLjK75MJbEz0XrmWUp+htIULPC4XXA9BUTToBCIVfU/YYo1wezrhb8S/6P8VbNh
 YeYuJ9YodHfmv6wP7MzWekzR3t9blvtyo2ON9lqyiah4XVj2Sdc14FVLE/uM4VNPLV3T
 vU7/2abRDtg3rjg5vLSTa6SGAFAJPFV8ZXD+oHy3jWE8vjyFnlJlGTOFaEiy1JezhvKZ ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34n73tvws7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 10:47:37 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A6FXVmv073394;
        Fri, 6 Nov 2020 10:47:37 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34n73tvwqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 10:47:37 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A6FX6Da006315;
        Fri, 6 Nov 2020 15:47:34 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 34jbytth87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 15:47:34 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A6FlWkR8061574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Nov 2020 15:47:32 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 365F8A4069;
        Fri,  6 Nov 2020 15:47:32 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6911CA4054;
        Fri,  6 Nov 2020 15:47:28 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.77.67])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Nov 2020 15:47:28 +0000 (GMT)
Message-ID: <fb886663efb2b333b1dcd5182b049e5887546662.camel@linux.ibm.com>
Subject: Re: [PATCH v5 7/7] selinux: measure state and hash of the policy
 using IMA
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Fri, 06 Nov 2020 10:47:27 -0500
In-Reply-To: <20201101222626.6111-8-tusharsu@linux.microsoft.com>
References: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
         <20201101222626.6111-8-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_06:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011060109
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi, Tushar,

On Sun, 2020-11-01 at 14:26 -0800, Tushar Sugandhi wrote:
> From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> 
> Critical data structures of security modules are currently not measured.

Right, this patch set adds support for measuring kernel integrity
critical data.  Why is this statement needed?

> Therefore an attestation service, for instance, would not be able to
> attest whether the security modules are always operating with the policies
> and configurations that the system administrator had setup. The policies
> and configurations for the security modules could be tampered by rogue
> user mode agents or modified through some inadvertent actions on
> the system. Measuring such critical data would enable an attestation
> service to reliably assess the security configuration of the system.

Please rewrite this paragraph from the perspective of measuring files
and other buffer data is not sufficient, providing an explanation why
it is isn't sufficient.

This is a rather large patch.   I'm surprised that it isn't broken up
into two patches, one that measures SELinux policy data and another
which measures the state, but that is Stephen's and Paul's call.

Mimi


> SELinux configuration and policy are some of the critical data for this
> security module that need to be measured. This measurement can be used
> by an attestation service, for instance, to verify if the configurations
> and policies have been setup correctly and that they haven't been
> tampered at run-time.
> 
> Measure SELinux configurations, policy capabilities settings, and
> the hash of the loaded policy by calling the IMA hook
> ima_measure_critical_data(). Since the size of the loaded policy can
> be large (several MB), measure the hash of the policy instead of
> the entire policy to avoid bloating the IMA log entry.
> 
> Add "selinux" to the list of supported data sources maintained by IMA
> to enable measuring SELinux data.
> 
> To enable SELinux data measurement, the following steps are required:
> 
> 1, Add "ima_policy=critical_data" to the kernel command line arguments
>    to enable measuring SELinux data at boot time.
> For example,
>   BOOT_IMAGE=/boot/vmlinuz-5.10.0-rc1+ root=UUID=fd643309-a5d2-4ed3-b10d-3c579a5fab2f ro nomodeset security=selinux ima_policy=critical_data
> 
> 2, Add the following rule to /etc/ima/ima-policy
>    measure func=CRITICAL_DATA data_sources=selinux template=ima-buf
> 
> Sample measurement of SELinux state and hash of the policy:
> 
> 10 e32e...5ac3 ima-buf sha256:86e8...4594 selinux-state-1595389364:287899386 696e697469616c697a65643d313b656e61626c65643d313b656e666f7263696e673d303b636865636b72657170726f743d313b6e6574776f726b5f706565725f636f6e74726f6c733d313b6f70656e5f7065726d733d313b657874656e6465645f736f636b65745f636c6173733d313b616c776179735f636865636b5f6e6574776f726b3d303b6367726f75705f7365636c6162656c3d313b6e6e705f6e6f737569645f7472616e736974696f6e3d313b67656e66735f7365636c6162656c5f73796d6c696e6b733d303
> 10 9e81...0857 ima-buf sha256:4941...68fc selinux-policy-hash-1597335667:462051628 8d1d...1834
> 
> To verify the measurement check the following:
> 
> Execute the following command to extract the measured data
> from the IMA log for SELinux configuration (selinux-state).
> 
>   grep "selinux-state" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | tail -1 | cut -d' ' -f 6 | xxd -r -p
> 
> The output should be the list of key-value pairs. For example,
>  initialized=1;enabled=1;enforcing=0;checkreqprot=1;network_peer_controls=1;open_perms=1;extended_socket_class=1;always_check_network=0;cgroup_seclabel=1;nnp_nosuid_transition=1;genfs_seclabel_symlinks=0;
> 
> To verify the measured data with the current SELinux state:
> 
>  => enabled should be set to 1 if /sys/fs/selinux folder exists,
>     0 otherwise
> 
> For other entries, compare the integer value in the files
>  => /sys/fs/selinux/enforce
>  => /sys/fs/selinux/checkreqprot
> And, each of the policy capabilities files under
>  => /sys/fs/selinux/policy_capabilities
> 
> Note that the actual verification would be against an expected state
> and done on a system other than the measured system, typically
> requiring "initialized=1; enabled=1;enforcing=1;checkreqprot=0;" for
> a secure state and then whatever policy capabilities are actually set
> in the expected policy (which can be extracted from the policy itself
> via seinfo, for example).
> 
> For selinux-policy-hash, the hash of SELinux policy is included
> in the IMA log entry.
> 
> To verify the measured data with the current SELinux policy run
> the following commands and verify the output hash values match.
> 
>   sha256sum /sys/fs/selinux/policy | cut -d' ' -f 1
> 
>   grep "selinux-policy-hash" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | tail -1 | cut -d' ' -f 6
> 
> Note that the actual verification of SELinux policy would require loading
> the expected policy into an identical kernel on a pristine/known-safe
> system and run the sha256sum /sys/kernel/selinux/policy there to get
> the expected hash.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Please reverse the order of the tags.

thanks,

Mimi

