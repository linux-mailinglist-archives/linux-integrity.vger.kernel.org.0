Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C44F53D103
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jun 2019 17:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390398AbfFKPhZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jun 2019 11:37:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388863AbfFKPhY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jun 2019 11:37:24 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BFVsvV049042
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jun 2019 11:37:24 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2cxqyd6w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jun 2019 11:37:23 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 11 Jun 2019 16:37:21 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Jun 2019 16:37:19 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5BFbId730212220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 15:37:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A18B6A4051;
        Tue, 11 Jun 2019 15:37:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCB81A405E;
        Tue, 11 Jun 2019 15:37:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.81.78])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jun 2019 15:37:17 +0000 (GMT)
Subject: Re: [PATCH v7 0/3] add new ima hook ima_kexec_cmdline to measure
 kexec boot cmdline args
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Prakhar Srivastava <prsriva02@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     roberto.sassu@huawei.com, vgoyal@redhat.com
Date:   Tue, 11 Jun 2019 11:37:06 -0400
In-Reply-To: <20190607002330.2999-1-prsriva02@gmail.com>
References: <20190607002330.2999-1-prsriva02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061115-0016-0000-0000-000002882983
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061115-0017-0000-0000-000032E558E5
Message-Id: <1560267426.4464.173.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110101
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Prakhar,

The patch/patch set title in the Subject line should not explain "how"
you add a new feature.  In this case an appropriate patch set title
would be, "Add support for measuring the boot command line".
 Similarly, the first patch in this patch set could be named "Define a
new IMA hook to measure the boot command line arguments".

On Thu, 2019-06-06 at 17:23 -0700, Prakhar Srivastava wrote:
> The motive behind the patch series is to measure the boot cmdline args
> used for soft reboot/kexec case.

When mentoring, I suggest starting out with a simple status statement
(eg. "The kexec boot command line arguments are not currently being
measured."), followed by the problem statement in the first paragraph.

> 
> For secure boot attestation, it is necessary to measure the kernel

Secure boot enforces local file data integrity.  The term here should
be "trusted boot attestation".

> command line and the kernel version. 

The original version of this patch set included the kernel version.  
This version is just measuring the boot command line arguments.

> For cold boot, the boot loader
> can be enhanced to measure these parameters.
> (https://mjg59.dreamwidth.org/48897.html)
> However, for attestation across soft reboot boundary, these values 
> also need to be measured during kexec_file_load.
> 
> Currently for Kexec(kexec_file_load)/soft reboot scenario the boot cmdline
> args for the next kernel are not measured. For 
> normal case of boot/hardreboot the cmdline args are measured into the TPM.
> The hash of boot command line is calculated and added to the current 
> running kernel's measurement list.
> On a soft reboot like kexec, no cmdline arguments measurement takes place.
> 
> To achive the above the patch series does the following
>   -adds a new ima hook: ima_kexec_cmdline which measures the cmdline args
>    into the ima log, behind a new ima policy entry KEXEC_CMDLINE.
>   -since the cmldine args cannot be appraised, a new template field(buf) is
>    added. The template field contains the buffer passed(cmldine args), which
>    can be used to appraise/attest at a later stage.
>   -call the ima_kexec_cmdline(...) hook from kexec_file_load call.
> 
> The ima logs need to be carried over to the next kernel, which will be followed
> up by other patchsets for x86_64 and arm64.
> 
> The kexec cmdline hash

^stored in the "d-ng" field of the template data

> can be verified using

> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements | 
>   grep  kexec-cmdline | cut -d' ' -f 6 | xxd -r -p | sha256sum

Until per policy template field rule support is added, a template name
needs to be defined.  Please define "ima-buf" as:
{.name = "ima-buf", .fmt = "d-ng|n-ng|buf"}

I'm still seeing some scripts/checkpatch "WARNING: line over 80
characters".  scripts/Lindent should provide the correct way of
formatting these lines.

Some people feel that references to Lindent should be removed, but I
tend to agree with the Documentation/hwmon/submitting-patches.rst
comment pertaining to scripts/Lindent.

"* Running your patch or driver file(s) through checkpatch does not
mean its formatting is clean. If unsure about formatting in your new
driver, run it through Lindent. Lindent is not perfect, and you may
have to do some minor cleanup, but it is a good start."

Examples of where the line formatting is off is the call to
ima_get_action() in process_buffer_measurement() and the call to
process_buffer_measurement() in ima_kexec_cmdline().

thanks,

Mimi

> 
> Changelog:
> V7:
>   - rebased to next-queued-testing
>   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/log/?h=next-queued-testing
> 
> V6:
>   -add a new ima hook and policy to measure the cmdline
>     args(ima_kexec_cmdline)
>   -add a new template field buf to contain the buffer measured.
>   [suggested by Mimi Zohar]
>    add new fields to ima_event_data to store/read buffer data.
>   [suggested by Roberto]
>   -call ima_kexec_cmdline from kexec_file_load path
> 
> v5:
>   -add a new ima hook and policy to measure the cmdline
>     args(ima_kexec_cmdline)
>   -add a new template field buf to contain the buffer measured.
>     [suggested by Mimi Zohar]
>   -call ima_kexec_cmdline from kexec_file_load path
> 
> v4:
>   - per feedback from LSM community, removed the LSM hook and renamed the
>     IMA policy to KEXEC_CMDLINE
> 
> v3: (rebase changes to next-general)
>   - Add policy checks for buffer[suggested by Mimi Zohar]
>   - use the IMA_XATTR to add buffer
>   - Add kexec_cmdline used for kexec file load
>   - Add an LSM hook to allow usage by other LSM.[suggestd by Mimi Zohar]
> 
> v2:
>   - Add policy checks for buffer[suggested by Mimi Zohar]
>   - Add an LSM hook to allow usage by other LSM.[suggestd by Mimi Zohar]
>   - use the IMA_XATTR to add buffer instead of sig template
> 
> v1:
>   -Add kconfigs to control the ima_buffer_check
>   -measure the cmdline args suffixed with the kernel file name
>   -add the buffer to the template sig field.
> 
> Prakhar Srivastava (3):
>   Add a new ima hook ima_kexec_cmdline to measure cmdline args
>   add a new ima template field buf
>   call ima_kexec_cmdline to measure the cmdline args
> 
>  Documentation/ABI/testing/ima_policy      |  1 +
>  Documentation/security/IMA-templates.rst  |  2 +-
>  include/linux/ima.h                       |  2 +
>  kernel/kexec_file.c                       |  8 ++-
>  security/integrity/ima/ima.h              |  3 +
>  security/integrity/ima/ima_api.c          |  5 +-
>  security/integrity/ima/ima_init.c         |  2 +-
>  security/integrity/ima/ima_main.c         | 80 +++++++++++++++++++++++
>  security/integrity/ima/ima_policy.c       |  9 +++
>  security/integrity/ima/ima_template.c     |  2 +
>  security/integrity/ima/ima_template_lib.c | 20 ++++++
>  security/integrity/ima/ima_template_lib.h |  4 ++
>  12 files changed, 131 insertions(+), 7 deletions(-)
> 

