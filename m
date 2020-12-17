Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6702F2DCBDF
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Dec 2020 06:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgLQFYT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Dec 2020 00:24:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726500AbgLQFYT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Dec 2020 00:24:19 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BH5LeoR176412;
        Thu, 17 Dec 2020 00:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=llkejhj818LCyBrjASo3rzEqfPiGj9/3uGNHSYRN8os=;
 b=Z8MRqozao4VzrMKjBGk67kdw6tmnRt1Jf7A12c/IE5LRHa7Y0c25EQkr2j/sxrN4AJl7
 F7TlMgxGPWg5V0Zp/I3N5UKMl4xGNV8TTjHzyrpXM0B30wIwR8a5Ho8euBet7fsygqLX
 KljIyztWeHFauyfDMOQmk1p07F2prVQyz3xYtEk7jh58X1I0qlpPTsZOKyDpSnBAk3Ok
 B+iS4ub6h0WyWRFBB81eNwaaw8jIItiaOhP4BIBlFOLQ2HuboLV+1QKgsqJGZSaP/RZ3
 WwcLEw2PZIblZJj5C7uDZhx9RjbPMJBjp4DhWjkPvvxlun1oCJP12kYWPqytMViZBQFl Uw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35g14880pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 00:23:31 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BH5NTWp013104;
        Thu, 17 Dec 2020 05:23:29 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 35cng8fcuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 05:23:29 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BH5KvOR11600128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Dec 2020 05:20:57 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3B344C058;
        Thu, 17 Dec 2020 05:20:57 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 481DF4C050;
        Thu, 17 Dec 2020 05:20:56 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.2.170])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Dec 2020 05:20:56 +0000 (GMT)
Message-ID: <aec8d4d757c674b3fdb4caaf3d89317d230b91e7.camel@linux.ibm.com>
Subject: Re: [PATCH v5 0/4] TPM 2.0 fixes in IMA tests
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 17 Dec 2020 00:20:55 -0500
In-Reply-To: <20201214221946.6340-1-pvorel@suse.cz>
References: <20201214221946.6340-1-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_03:2020-12-15,2020-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012170031
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Mon, 2020-12-14 at 23:19 +0100, Petr Vorel wrote:
> The only problem which bothers me is failure on ima_policy=tcb:
> 
> evmctl ima_measurement /sys/kernel/security/integrity/ima/binary_runtime_measurements -vv
> ...
> sha256: PCRAgg  10: c19866f10132282d4cf20ca45f50078db843f95dc8d1ea8819d0e240cdf3b21c
> sha256: TPM PCR-10: df913daa0437a2365f710f6d93a4f2d37146414425d9aaa60740dc635d187158
> sha256: PCRAgg 10 does not match TPM PCR-10
> Failed to match per TPM bank or SHA1 padded TPM digest(s) (count 1446)
> errno: No such file or directory (2)
> 
> Thus test get failure for the fist run without --ignore-violations
> ...
> ima_tpm 1 TINFO: using command: evmctl ima_boot_aggregate -v
> Using tss2-rc-decode to read PCRs.
> ima_tpm 1 TINFO: IMA boot aggregate: '0756853d9378ff6473966e20610a8d1cb97e4dc613cb87adf5e870c8eb93fd0f'
> ima_tpm 1 TPASS: bios boot aggregate matches IMA boot aggregate
> ima_tpm 2 TINFO: verify PCR values
> ima_tpm 2 TINFO: real PCR-10: '6d8aec6291c0c19efdee50e20899939135be073cd4d6e9063e53386f54f9487d'
> ima_tpm 2 TFAIL: evmctl failed, trying with --ignore-violations
> ima_tpm 2 TINFO: aggregate PCR-10: '6d8aec6291c0c19efdee50e20899939135be073cd4d6e9063e53386f54f9487d'
> ima_tpm 2 TPASS: aggregate PCR value matches real PCR value
> ima_tpm 3 TINFO: AppArmor enabled, this may affect test results
> ima_tpm 3 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
> ima_tpm 3 TINFO: loaded AppArmor profiles: none
> 
> Summary:
> passed   2
> failed   1
> skipped  0
> warnings 0
> 
> IMHO unless this is specific for this particular TPM we should skip test
> if ima_policy=tcb.

No, I don't think so.  Violations are a result of a file being opened
for read and write at the same time.  Opening a file for write, when it
is already open for read, results in a Time of Measure/Time of Use
(ToMToU) violation.  Opening a file for read, when it is already open
for write, results in an open_writer violation.  One of the more common
reasons for these violations are log files.

With the builtin TCB measurement policy enabled on the boot command
line, files are measured from the beginning, before a custom policy is
loaded.  Normally a custom policy is loaded after an LSM policy has
been loaded, allowing IMA policy rules to be defined in terms of LSM
labels.

Verifying the IMA measurement list against the TPM PCRs is an important
test.  Ignoring violations doesn't make sense either.   Perhaps if a
custom policy has not been loaded, emit an informational message and
skip the test without "--ignore-violations".

thanks,

Mimi

