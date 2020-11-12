Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445902B1170
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Nov 2020 23:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgKLW0S (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Nov 2020 17:26:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726437AbgKLW0Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Nov 2020 17:26:16 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ACMLeel075494;
        Thu, 12 Nov 2020 17:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=V284/SocAd83xMJk7GKqJiUIAHSyaGCIqb0XsIpVZMg=;
 b=Ky4SZBdbgNC0oQHAsczYHBJ/4HfZ4egs+oCNww2q25sQialC8x7rVqoFNvP/JtdWYeXl
 J2n6+Ah5vjDT2msLwAasfhct6LgBXHrLkkE5BfS/pAPVXLwk81wrCJ0yg84afIwc6OR5
 cbQNsFOzY2YMYs4ZXZssnQGrI23m73YW8QCEd+3513bz4vo4QWjvfYgulzoB3Qb+eQQa
 qiczm2TzGbo83MMbR1zrgO6nJWHyhW2FEUQp4j3kRouMXfFj80AZN2pOlwDi51nrnbpN
 CkjqVhB9B6K362TQ78bcsJZFvarcRrsO+D33SbIMoCFdHicyfbkEjRCf+Mh4oWD5fYhq fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34sc39tkxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 17:26:10 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0ACMLfUj075596;
        Thu, 12 Nov 2020 17:26:10 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34sc39tkx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 17:26:10 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ACMEMM8027040;
        Thu, 12 Nov 2020 22:19:36 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 34njuh63rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 22:19:35 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0ACMJX1V57540880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 22:19:33 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1C8B11C04C;
        Thu, 12 Nov 2020 22:19:33 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 862A411C050;
        Thu, 12 Nov 2020 22:19:30 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.105.204])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Nov 2020 22:19:30 +0000 (GMT)
Message-ID: <0fa1a12388681b49167b58e349cb7c9e996dcd05.camel@linux.ibm.com>
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
Date:   Thu, 12 Nov 2020 17:19:29 -0500
In-Reply-To: <7034a775-cde6-1eae-132a-4cb84f310bca@linux.microsoft.com>
References: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
         <20201101222626.6111-3-tusharsu@linux.microsoft.com>
         <d0e96ccc49590c5ff11675661592b70b0f021636.camel@linux.ibm.com>
         <7034a775-cde6-1eae-132a-4cb84f310bca@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_13:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120124
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-11-12 at 13:47 -0800, Tushar Sugandhi wrote:
> > On Sun, 2020-11-01 at 14:26 -0800, Tushar Sugandhi wrote:
> >> process_buffer_measurement() currently only measures the input buffer.
> >> In case of SeLinux policy measurement, the policy being measured could
> >> be large (several MB). This may result in a large entry in IMA
> >> measurement log.
> > 
> > SELinux is an example of measuring large buffer data.  Please rewrite
> > this patch description (and the other patch descriptions in this patch
> > set) without using the example to describe its purpose [1].
> > 
> > In this case, you might say,
> > 
> > The original IMA buffer data measurement sizes were small (e.g. boot
> > command line), but new buffer data measurement use cases are a lot
> > larger.  Just as IMA measures the file data hash, not the file data,
> > IMA should similarly support measuring the buffer data hash.
> > 
> Sure. Thanks a lot for giving an example wording for us. Will update.
> >>
> >> Introduce a boolean parameter measure_buf_hash to support measuring
> >> hash of a buffer, which would be much smaller, instead of the buffer
> >> itself.
> > 
> >> To use the functionality introduced in this patch, the attestation
> >> client and the server changes need to go hand in hand. The
> >> client/kernel would know what data is being measured as-is
> >> (e.g. KEXEC_CMDLINE), and what data has it’s hash measured (e.g. SeLinux
> >> Policy). And the attestation server should verify data/hash accordingly.
> >>
> >> Just like the data being measured in other cases, the attestation server
> >> will know what are possible values of the large buffers being measured.
> >> e.g. the possible valid SeLinux policy values that are being pushed to
> >> the client. The attestation server will have to maintain the hash of
> >> those buffer values.
> > 
> > Each patch in the patch set builds upon the previous one.   (Think of
> > it as a story, where each chapter builds upon the previous ones.)
> > With rare exceptions, should patches reference subsequent patches. [2]
> > 
> > [1] Refer to Documentation/process/submitting-patches.rst
> > [2] Refer to the section "8) Commenting" in
> > Documentation/process/coding-style.rst
> > 
> I am not sure if you have any concerns about the last two paragraphs.
> The description about the attestation client and server (the last two
> paragraphs) was added for information/clarification purpose only, as per
> your feedback on previous iterations. The subsequent patches don’t have
> any code pertaining to attestation client/server.
> 
> *Question*
> Maybe the last two paragraphs are confusing/redundant. Could you please
> let me know if I should remove the above two paragraphs altogether? 
> (starting with “To use the functionality introduced in this patch ...”)
> 
> If we decide to keep the paragraphs, I will remove the specific examples
> (KEXEC_CMDLINE, SeLinux etc.) as you mentioned elsewhere.

Instead of the above two paragraphs, perhaps explain how measuring the
file data hash differs from measuring the buffer data hash.  Keep the
explanation generic, short and simple.

Mimi

