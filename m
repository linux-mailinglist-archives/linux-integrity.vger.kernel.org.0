Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E4A27D92D
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Sep 2020 22:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgI2UqV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 16:46:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbgI2UqV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 16:46:21 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TKY3WX075093;
        Tue, 29 Sep 2020 16:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=P9BdbJ5lDm5Ja3H1kMmUeU7cTrhK/Dc9X8xQ13yRYOQ=;
 b=MrdXtKdsKPlOABp/XwTdOx3uaNj2QkHfaviiVE35uxTQdlI/DhWqH14eVi2aT1yOE/Fv
 bjuQSICT2g2i2bt39IZdninXt3dbr45Sk/Rtp3ICGuS/SevXnxT/GRJCr/hcwN+awvWH
 APl6Ak/BXANiCP+pmOChk6JTaX/W2i6x6fHBEtMSkIg5C07dKpa+bCedCTZs2m7YDE0p
 HQ4EN8YCcoSRDs0MnE0X2imTXc5Hk6afWLPTdXcxaOZUouC6VgtpZSMa1ycPh+b4YpDk
 AjlqPwCbWgRDdp6HfVh3ybyJysPY6IeEVjzhtxXnmeKOT8e7gdJsti0TvXs5KIdKxaOo WQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33vb75sqpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 16:46:13 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08TKgfgm024392;
        Tue, 29 Sep 2020 20:46:11 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 33sw989y0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 20:46:11 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08TKk97q29360512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 20:46:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D2F952051;
        Tue, 29 Sep 2020 20:46:09 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.90.38])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C245A5204E;
        Tue, 29 Sep 2020 20:46:07 +0000 (GMT)
Message-ID: <b249ba7ba369810e28c3653c4dfd23ca3ac9d1d8.camel@linux.ibm.com>
Subject: Re: [PATCH v3 3/4] ima_tpm.sh: Fix calculating boot aggregate
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 29 Sep 2020 16:46:07 -0400
In-Reply-To: <20200929165021.11731-4-pvorel@suse.cz>
References: <20200929165021.11731-1-pvorel@suse.cz>
         <20200929165021.11731-4-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_14:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290174
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-09-29 at 18:50 +0200, Petr Vorel wrote:
> for TPM 2.0 or kernel >= v5.8-rc1:
> 6f1a1d103b48 ima: ("Switch to ima_hash_algo for boot aggregate")
> 
> Test still fails with TPM 2.0 on kernel < v5.8-rc1.
> 
> Test was failing, because it expect SHA1 hash, but for TPM 2.0 is
> now used IMA default hash algorithm (by default default SHA256).

TPM 1.2 only supported MD5 and SHA1, at least the IMA measurement list
did.  (This is probably the reason it searched for "boot_aggregate" and
not "sha1".)  Nobody should be using MD5, so the boot_aggregate for TPM
1.2 should always be SHA1.

For TPM 2.0, which supports multiple algorithms, it's a bit more
complicated.  The hash algorithm used for calculating the
"boot_aggregate" is dependent on which TPM bank is enabled.  For
example, even if the default IMA measurement hash is defined as SHA256,
but the TPM 2.0 SHA256 bank isn't enabled, it will fall back to
calculating a SHA1 "boot_aggregate".

For backwards compatibility, the SHA1 boot_aggregate is based on PCRs 0
-7, while all others include PCRs 0 - 9.

> This is similar for entries in IMA measurement list so we can reuse
> already existing code.
> 
> Reading other algorithms than sha1 or TPM 2.0 requires evmctl >= 1.3.
> Although recent evmctl is recommended, to support older kernels when
> sha1 is used, get boot aggregate with old our legacy ima_boot_aggregate.c.

For example, some PTT firmware (TPM 2.0) only supports SHA1.  (I've
seen some TPM 2.0's using the TPM 1.2 event log format.)   Instead of
saying, "to support older kernels when sha1 is used, get boot_aggregate
...", it should say "to support older TPMs, calculate the
"boot_aggregate" with ...cat

One of the major differences is that the original TPM 1.2 support
walked the TPM event log, extending the PCRs.  Only after re-
calculating the PCRs, would it calculate the "boot_aggregate".  The TPM
2.0 support assumes that some other mechanism exists for verifying the
PCRs against the TPM event log* and just calculates the
"boot_aggregate" based on the existing TPM PCR values.

* tsseventextend -sim -if
/sys/kernel/security/tpm0/binary_bios_measurements  -v -ns

Mimi

> 
> Also fixed test without TPM device (when IMA TPM-bypass is tested)
> as some TPM 2.0 devices does not export event log
> (/sys/kernel/security/tpm0/binary_bios_measurements).
> This does not require evmctl at all.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v2->v3:
> * separate testing real HW and IMA TPM-bypass into it's own functions
> * fixed checking in check_evmctl
> * improve get_tpm_version to not depend on having dmesg on IMA TPM-bypass
> 
> Kind regards,
> Petr

