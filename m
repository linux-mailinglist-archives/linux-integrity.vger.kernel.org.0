Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416AE2A80EE
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Nov 2020 15:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbgKEOap (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Nov 2020 09:30:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31606 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727275AbgKEOao (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Nov 2020 09:30:44 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A5E2RHA069793;
        Thu, 5 Nov 2020 09:30:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=S9CJWToNLpkKaCorY29bqvxp8f7JEx0XR/Lr9uF/huY=;
 b=nUZHSYOpknxeIn3PzQzenFH35XSGFkI39rU2Iv/FbkbzQKU4PyJBQBCc5ebWOOpgv7nm
 GvMaW6E2y7rAoZgQ+9LmLfid0iogBBCYJpO85IOgCyKOTTieE6h97jSh0yIMQ2Mno6kr
 Fge88ybimz4piCdf50sota/VMyqPJT38x/f7zk/QRbwpy/CDw/qmfvdlVmVjl0Wr+lFB
 eblyoiYRL/yCaz98cDyG3IiXAYStSHkcMsnp8903KUiP1vz2eDZnreD+0pFhkPyxPUKj
 EjDb6mBkysNonJg0PWxc4TPhzaZYDfmACcArF+1H4ShbhiYcOG2zOYiZE6PtbYQoYkc1 vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34m5ftg0w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Nov 2020 09:30:36 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A5E3Bwc077583;
        Thu, 5 Nov 2020 09:30:35 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34m5ftg0ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Nov 2020 09:30:35 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A5ER9Dg016507;
        Thu, 5 Nov 2020 14:30:32 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 34h0fcwh52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Nov 2020 14:30:32 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A5EUUee56426984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Nov 2020 14:30:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FDD6AE051;
        Thu,  5 Nov 2020 14:30:30 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47954AE04D;
        Thu,  5 Nov 2020 14:30:27 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.97.46])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Nov 2020 14:30:27 +0000 (GMT)
Message-ID: <d0e96ccc49590c5ff11675661592b70b0f021636.camel@linux.ibm.com>
Subject: Re: [PATCH v5 2/7] IMA: update process_buffer_measurement to
 measure buffer hash
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Thu, 05 Nov 2020 09:30:26 -0500
In-Reply-To: <20201101222626.6111-3-tusharsu@linux.microsoft.com>
References: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
         <20201101222626.6111-3-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_07:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011050092
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

Please don't include the filename in the Subject line[1].   The Subject
line should be a summary phrase describing the patch.   In this case,
it is adding support for measuring the buffer data hash.

On Sun, 2020-11-01 at 14:26 -0800, Tushar Sugandhi wrote:
> process_buffer_measurement() currently only measures the input buffer.
> In case of SeLinux policy measurement, the policy being measured could
> be large (several MB). This may result in a large entry in IMA
> measurement log.

SELinux is an example of measuring large buffer data.  Please rewrite
this patch description (and the other patch descriptions in this patch
set) without using the example to describe its purpose [1].

In this case, you might say,

The original IMA buffer data measurement sizes were small (e.g. boot
command line), but new buffer data measurement use cases are a lot
larger.  Just as IMA measures the file data hash, not the file data,
IMA should similarly support measuring the buffer data hash.

> 
> Introduce a boolean parameter measure_buf_hash to support measuring
> hash of a buffer, which would be much smaller, instead of the buffer
> itself.

> To use the functionality introduced in this patch, the attestation
> client and the server changes need to go hand in hand. The
> client/kernel would know what data is being measured as-is
> (e.g. KEXEC_CMDLINE), and what data has it’s hash measured (e.g. SeLinux
> Policy). And the attestation server should verify data/hash accordingly.
> 
> Just like the data being measured in other cases, the attestation server
> will know what are possible values of the large buffers being measured.
> e.g. the possible valid SeLinux policy values that are being pushed to
> the client. The attestation server will have to maintain the hash of
> those buffer values.

Each patch in the patch set builds upon the previous one.   (Think of
it as a story, where each chapter builds upon the previous ones.)  
With rare exceptions, should patches reference subsequent patches. [2]

[1] Refer to Documentation/process/submitting-patches.rst
[2] Refer to the section "8) Commenting" in
Documentation/process/coding-style.rst

thanks,

Mimi

