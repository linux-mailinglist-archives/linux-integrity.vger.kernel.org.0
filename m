Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E8231501A
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Feb 2021 14:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhBINYl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Feb 2021 08:24:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230414AbhBINYl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Feb 2021 08:24:41 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 119DEJQ2105783;
        Tue, 9 Feb 2021 08:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=+qK5gdmrbMHFtDB+mzARTjE720ai6eZDPHUcqn9jDu4=;
 b=nyD3CNxOEmAtb55z21CwjYmvH7okzd93KQIN/ltfLkA6oIWDlVXGpRS8l+389k8bjn8d
 oVkc0Or5n9IvpkCPAYsqX8bowA7IiDMSiMrNnRzrkhS3JHprrr2R8iKQz79FYivksmWo
 j3s4FGPeuxIO+Fzsgkl7oKIXl/C4BalSciuaMEm+TR9PiFQDDUsD8iuL9C7w2okG6cwj
 ATWJBRvRNYJ3LhObJ3DpRs+mM7SDiO/kvDYV03jNV3WqLmawx33BleoQVRMn5ACIuU3U
 hPRBCDt1mNuulD5ncdEVF7A754WyUj0kZKGMB7eABkEY87/4p3LSwU+po64s7Z9Ks1sX jw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36ku3j09k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 08:23:58 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 119Cvj8J015986;
        Tue, 9 Feb 2021 13:23:56 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 36hjr81qra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 13:23:55 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 119DNhm929819194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Feb 2021 13:23:43 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0826C5279A;
        Tue,  9 Feb 2021 13:23:53 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.52.68])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 033B45279B;
        Tue,  9 Feb 2021 13:23:51 +0000 (GMT)
Message-ID: <8df2a4a81459124976d1e685afdf72e70a4ca26e.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima-evm-utils: Improve ima_measurement matching on
 busy system with >1 banks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, vt@altlinux.org,
        linux-integrity@vger.kernel.org
Date:   Tue, 09 Feb 2021 08:23:51 -0500
In-Reply-To: <20210209122106.870973-1-stefanb@linux.ibm.com>
References: <20210209122106.870973-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_03:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090067
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-02-09 at 07:21 -0500, Stefan Berger wrote:
> When a system is very busy with IMA taking measurements into more than
> one bank, then we often do not get the PCR 10 values of the sha1 bank
> that represents the same log entry as the reading of the PCR value of
> the sha256 bank. In other words, the reading of the PCR 10 value from
> the sha1 bank may represent the PCR 10 state at the time of the
> n-th entry in the log while the reading of the PCR 10 value from the
> sha256 bank may represent the state at the time of a later-than-n entry.
> The result currently is that the PCR measurements do not match and
> on a busy system the tool may not easily report a successful match.
> 
> This patch fixes this issue by separating the TPM bank comparison for
> each one of the banks being looked and using a bit mask for checking
> which banks have already been matched. Once the mask has become 0
> all PCR banks have been successfully matched.
> 
> A run on a busy system may result in the output as follows indicating
> PCR bank matches at the n-th entry for the sha1 bank and at a later
> entry, possibly n + 1 or n + 2 or so, for the sha256 bank. The
> output is interleaved with a match of the sha1 bank against 'padded
> matching'.
> 
> $ evmctl ima_measurement --ignore-violations /sys/kernel/security/ima/binary_runtime_measurements -v
> sha1: PCRAgg  10: 381cc6139e2fbda76037ec0946089aeccaaa5374
> sha1: TPM PCR-10: 381cc6139e2fbda76037ec0946089aeccaaa5374
> sha1 PCR-10: succeed at entry 4918
> sha1: PCRAgg  10: 381cc6139e2fbda76037ec0946089aeccaaa5374
> sha1: TPM PCR-10: 381cc6139e2fbda76037ec0946089aeccaaa5374
> sha1 PCR-10: succeed at entry 4918
> [...]
> sha256: PCRAgg  10: c21dcb7098b3d7627f7aaeddf8aff68a65209027274d82af52be2fd302193eb7
> sha256: TPM PCR-10: c21dcb7098b3d7627f7aaeddf8aff68a65209027274d82af52be2fd302193eb7
> sha256 PCR-10: succeed at entry 4922
> Matched per TPM bank calculated digest(s).
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
> v1->v2:
>  - Reporting entry number that resulted in a match when in verbose mode

Thanks,  Stefan.   This and your other two patches are now queued in
next-testing.

Mimi

