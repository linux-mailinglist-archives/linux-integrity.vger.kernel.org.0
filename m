Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CD42D3092
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Dec 2020 18:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbgLHRJc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Dec 2020 12:09:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728679AbgLHRJb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Dec 2020 12:09:31 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B8H53pE102777;
        Tue, 8 Dec 2020 12:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=MZ7ovSGWvDyzVOlz/bs+1cG//Ep+jGNzjI98A0YkdF0=;
 b=d20BGCCfUGfbibnjvvhOFSWhZ/z3xqLtbywy8JRivaZzKTiW4Q/v03i9AtHBCELsQrsa
 ii+JyhSMERpCQsOIJdWLwaKZ+NW7Tgds9ONI0LnBm52ZT7vZaQ1ByFKEERFEp23YJ43a
 MlgUrnYdAE7AsrZQI7u2CcyoI94v5gCCyIVzBw9wHS73eRAXG7UcBeyJpjtmKkEdF96Y
 X08hihoovRLKAt2S05nffmor4yMLBPTOpZtYD2KAElu1Y99L06GVcGoJYDO2CSftkQwv
 QChpRphuhIAg1lN611DnyeGcSt+MnxDUbI3E+UDxxdgdWw78RIG6mJVGGZHthYBUb/3E +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35a5ufyrpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 12:07:25 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B8H5P9t105606;
        Tue, 8 Dec 2020 12:07:24 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35a5ufyrms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 12:07:24 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B8H6gFB008135;
        Tue, 8 Dec 2020 17:07:21 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3581fhks5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 17:07:21 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B8H7I8m50528692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Dec 2020 17:07:18 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47EF152052;
        Tue,  8 Dec 2020 17:07:18 +0000 (GMT)
Received: from sig-9-65-221-14.ibm.com (unknown [9.65.221.14])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0240852057;
        Tue,  8 Dec 2020 17:07:13 +0000 (GMT)
Message-ID: <6c0428647fc83c2220e15e62dc1b566d250b7968.camel@linux.ibm.com>
Subject: Re: [PATCH v8 3/4] doc: trusted-encrypted: updates with TEE as a
 new trust source
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Sumit Garg <sumit.garg@linaro.org>,
        jarkko.sakkinen@linux.intel.com, jejb@linux.ibm.com,
        Elaine Palmer <erpalmer@us.ibm.com>
Cc:     dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, lhinds@redhat.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        George Wilson <gcwilson@us.ibm.com>
Date:   Tue, 08 Dec 2020 12:07:13 -0500
In-Reply-To: <f00c8c7dd1e184e139e6cb5aba2b4a1c5fc68363.camel@linux.ibm.com>
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
         <1604419306-26105-4-git-send-email-sumit.garg@linaro.org>
         <f00c8c7dd1e184e139e6cb5aba2b4a1c5fc68363.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_14:2020-12-08,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080104
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Sumit, Jarkko,

On Tue, 2020-12-08 at 10:55 -0500, Mimi Zohar wrote:
> Re-posting Elaine Palmer's comments, inline below, trimmed and properly
> formatted.

Continued ...

Thank you for the detailed descriptions and examples of trust sources
for Trusted Keys.  A group of us in IBM (Stefan Berger, Ken Goldman,
Zhongshu Gu, Nayna Jain, Elaine Palmer, George Wilson, Mimi Zohar) have
some concerns with extending trusted keys to new sources without
providing a threat model.   The following is based on our internal
discussions.

> * Threat model
> 
> The strength and appropriateness of TPMs and TEEs for a given purpose
> must be assessed when using them to protect security-relevant data.

The original Trusted Keys implementation assumed discrete physical TPMs
for key protection[1].  However, even physical TPMs themselves vary
based on the manufacturer and systems in which they are placed.  The
embedded chipset, firmware load, algorithms, packaging, pins, and
countermeasures vary.  (Threats and mitigations on physical TPMs are
well documented, e.g., "Threat Model of a Scenario Based on Trusted
Platform Module 2.0 Specification” (http://ceur-ws.org/Vol-1011/6.pdf).

Extending Trusted Keys to support new trust sources needs to provide
consumers of these new sources enough information so that they can
create their own threat models tailored to their use cases.

Just as each new LSM needs to comply with Documentation/security/lsm-
development.rst, we recommend each new source should provide a high-
level threat model.  We suggest documenting environmental assumptions
and dependencies in a high-level threat model for each additional trust
source.  An example of a high-level threat model is "Common Security
Threats v1.0” (
https://www.opencompute.org/documents/common-security-threats-notes-1-pdf
 ).

Thank you,

Elaine (and Mimi)


[1] Specific to Trusted Keys and TPMs, there is some discussion of
threats and mitigations in the Integrity_overview.pdf on the IMA wiki:

"The trusted key component does two things to help with secure key management on Linux. First, it provides a kernel key ring service in which the symmetric encryption keys are never visible in plain text to userspace. The keys are created in the kernel, and sealed by a hardware device such as a TPM, with userspace seeing only the sealed blobs. Malicious or compromised applications cannot steal a trusted key, since only the kernel can see the unsealed blobs. Secondly, the trusted keys can tie key unsealing to the integrity measurements, so that keys cannot be stolen in an offline attack, such as by booting an unlocked Linux image from CD or USB.  As the measurements will be different, the TPM chip will refuse to unseal the keys, even for the kernel."

