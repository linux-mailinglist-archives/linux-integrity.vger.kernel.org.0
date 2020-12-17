Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D882DD948
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Dec 2020 20:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgLQTYJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Dec 2020 14:24:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727260AbgLQTYJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Dec 2020 14:24:09 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BHJILm1054663;
        Thu, 17 Dec 2020 14:23:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=tmEF2eYITTXtmoS/qTIwTovfvgP63x2tppyxyCHucg8=;
 b=r4ogbwpo795E8rIFTxmAjWN1XUuobnrIrBd7NIjK8mhY3lSHTYI2DPTy0Nx+3/QTFNn1
 +4sC8Cg13ld+pgVPe+AjeneefweKXk8xC8hWwm0PxLm8c8+HNce6DNOYyHw93UBM+NT1
 mBI6xf7g3JIiqxSaC/SXH/uEUREHgHDr128Pg5t2LdLRc2ysDgyEgul4fxSLwPEbe7Tc
 7NNd/gLmmDYb9dJ70piXY2CPm2TijYC9YOuesf9RiX3qXgMsM6eyx3ncR7X0HB8TQTs5
 KoVZSW3UyZq95DwbV4yslRsGT1sPg8b+fseVIL89Pm1sMNdBfgxQWImr9fN1S2yyXojo EQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35gdceg3mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 14:23:19 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BHJJoxr012409;
        Thu, 17 Dec 2020 19:23:17 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 35cng8ay25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 19:23:17 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BHJNFKW50135434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Dec 2020 19:23:15 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED37652050;
        Thu, 17 Dec 2020 19:23:14 +0000 (GMT)
Received: from sig-9-65-203-134.ibm.com (unknown [9.65.203.134])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5F76A52065;
        Thu, 17 Dec 2020 19:23:13 +0000 (GMT)
Message-ID: <3df04bcb427a225de4fe7cb4886a3539b8735dbc.camel@linux.ibm.com>
Subject: Re: [PATCH v5 0/4] TPM 2.0 fixes in IMA tests
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 17 Dec 2020 14:23:12 -0500
In-Reply-To: <X9sXxGacmaPYN8hp@pevik>
References: <20201214221946.6340-1-pvorel@suse.cz>
         <aec8d4d757c674b3fdb4caaf3d89317d230b91e7.camel@linux.ibm.com>
         <X9sXxGacmaPYN8hp@pevik>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_13:2020-12-17,2020-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012170126
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-12-17 at 09:33 +0100, Petr Vorel wrote:
> Hi Mimi,
> 
> > Hi Petr,
> 
> > On Mon, 2020-12-14 at 23:19 +0100, Petr Vorel wrote:
> > > The only problem which bothers me is failure on ima_policy=tcb:
> 
> > > evmctl ima_measurement /sys/kernel/security/integrity/ima/binary_runtime_measurements -vv
> > > ...
> > > sha256: PCRAgg  10: c19866f10132282d4cf20ca45f50078db843f95dc8d1ea8819d0e240cdf3b21c
> > > sha256: TPM PCR-10: df913daa0437a2365f710f6d93a4f2d37146414425d9aaa60740dc635d187158
> > > sha256: PCRAgg 10 does not match TPM PCR-10
> > > Failed to match per TPM bank or SHA1 padded TPM digest(s) (count 1446)
> > > errno: No such file or directory (2)
> 
> > > Thus test get failure for the fist run without --ignore-violations
> > > ...
> > > ima_tpm 1 TINFO: using command: evmctl ima_boot_aggregate -v
> > > Using tss2-rc-decode to read PCRs.
> > > ima_tpm 1 TINFO: IMA boot aggregate: '0756853d9378ff6473966e20610a8d1cb97e4dc613cb87adf5e870c8eb93fd0f'
> > > ima_tpm 1 TPASS: bios boot aggregate matches IMA boot aggregate
> > > ima_tpm 2 TINFO: verify PCR values
> > > ima_tpm 2 TINFO: real PCR-10: '6d8aec6291c0c19efdee50e20899939135be073cd4d6e9063e53386f54f9487d'
> > > ima_tpm 2 TFAIL: evmctl failed, trying with --ignore-violations
> > > ima_tpm 2 TINFO: aggregate PCR-10: '6d8aec6291c0c19efdee50e20899939135be073cd4d6e9063e53386f54f9487d'
> > > ima_tpm 2 TPASS: aggregate PCR value matches real PCR value
> > > ima_tpm 3 TINFO: AppArmor enabled, this may affect test results
> > > ima_tpm 3 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
> > > ima_tpm 3 TINFO: loaded AppArmor profiles: none
> 
> > > Summary:
> > > passed   2
> > > failed   1
> > > skipped  0
> > > warnings 0
> 
> > > IMHO unless this is specific for this particular TPM we should skip test
> > > if ima_policy=tcb.
> 
> > No, I don't think so.  Violations are a result of a file being opened
> > for read and write at the same time.  Opening a file for write, when it
> > is already open for read, results in a Time of Measure/Time of Use
> > (ToMToU) violation.  Opening a file for read, when it is already open
> > for write, results in an open_writer violation.  One of the more common
> > reasons for these violations are log files.
> 
> > With the builtin TCB measurement policy enabled on the boot command
> > line, files are measured from the beginning, before a custom policy is
> > loaded.  Normally a custom policy is loaded after an LSM policy has
> > been loaded, allowing IMA policy rules to be defined in terms of LSM
> > labels.
> 
> > Verifying the IMA measurement list against the TPM PCRs is an important
> > test.  Ignoring violations doesn't make sense either.   Perhaps if a
> > custom policy has not been loaded, emit an informational message and
> > skip the test without "--ignore-violations".
> 
> Thanks for an explanation. Agree, you're right. It's most likely wrong setup
> (there were some temporary files in /tmp and even postfix pid file in /var/run/),
> I need to properly setup dracut-ima. It'd be then good to document this, but I'd
> do it as separate effort.
> 
> So, can I merge the patchset with your ack/review-by?

Yes, I just finished reviewing the patches.   Other that clarifying the
patch descriptions and fixing the one typo  ("tmp" -> "tpm"), it looks
really.

thanks! 

Mimi

