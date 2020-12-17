Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9192DD938
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Dec 2020 20:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgLQTRD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Dec 2020 14:17:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60566 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725468AbgLQTRD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Dec 2020 14:17:03 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BHJ2lV7079179;
        Thu, 17 Dec 2020 14:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=kfxI1HWjfd4PoctBF4/+1gKVlKWO1q2BjovVTSoWqYk=;
 b=OnucnhF3BMBahMIrQf57BjVLLnWRZV6pb62IBUDQtrxUmJclCscDoDkkqteBo0nV3VqI
 sUrPUWDFWx90lIHBMIh6Yz7ElXg+xqdZBoPfI7OHL2bNC0pXiOwc+JMIG9Sm/FWlQ68W
 E+cK73B1EV2xHDqO9Mje3FW7Hi8Y1h3/lnGlhi7533kNVuGXebS28KExbKxA9BBNAq3S
 Cqo6glP11ZiGfFdUcUC2HSeoNCYERLnAQbMNtEQHLaTYMMzlzCi6g/hVRdRZbinVs2pu
 2GF3QQn7h34x5lPnzz6eI9LkGH1wnCot0CV2WyI3fdhu4HxrL171QW4jXoHdp9w+d4J3 CQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35gcyq8rpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 14:16:16 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BHJ8Ica027877;
        Thu, 17 Dec 2020 19:16:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 35fbp5hq6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 19:16:14 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BHJGCTg47644980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Dec 2020 19:16:12 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02278A407B;
        Thu, 17 Dec 2020 19:16:12 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98591A407C;
        Thu, 17 Dec 2020 19:16:10 +0000 (GMT)
Received: from sig-9-65-203-134.ibm.com (unknown [9.65.203.134])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Dec 2020 19:16:10 +0000 (GMT)
Message-ID: <b9408c3ccf8260d9a2232074c7a0433119b83d42.camel@linux.ibm.com>
Subject: Re: [PATCH v5 4/4] ima_tpm.sh: Fix calculating PCR aggregate
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 17 Dec 2020 14:16:04 -0500
In-Reply-To: <20201214221946.6340-5-pvorel@suse.cz>
References: <20201214221946.6340-1-pvorel@suse.cz>
         <20201214221946.6340-5-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_13:2020-12-17,2020-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012170126
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-12-14 at 23:19 +0100, Petr Vorel wrote:
> for TPM 2.0 and support more evmctl versions.
> 
> Because exporting PCR registers for TPM 2.0 has not been upstreamed [1],
> we use user space code, which requires evmctl >= 1.3.1 and tsspcrread.

Yes, really annoying.

> Using evmctl allows to test for TPM devices which does not export event
> log (/sys/kernel/security/tpm0/binary_bios_measurements).

Interesting way of phrasing the lack of a TPM 2.0 event log parser in
ima-evm-utils.   Until someone contributes a TPM 2.0 event log parser,
we're dependent on users verifying the event log against the TPM 2.0
PCR banks some other way (e.g. "tsseventextend -sim -if
/sys/kernel/security/tpm0/binary_bios_measurements -ns").

> 
> For TPM 1.2 read tpm0 device's pcrs file from sysfs. (tss1pcrread could
> be also used, but it's not yet packaged by distros.)
> 
> For old kernels which use SHA1/MD5, any evmctl version is required (evmctl
> ima_measurement was introduced in very old v0.7), but
> * newer sysctl path /sys/class/tpm/tpm0/device/pcrs requires evmctl 1.1
> * using ima_policy=tcb requires 1.3.1 due --ignore-violations
> 
> We now support output format of ima_measurement command for various
> evmctl versions:
> * 1.3: "sha256: TPM PCR-10:" (or other algorithm, e.g. "sha1:")
> * 1.1-1.2.1: "HW PCR-10:" (the only previously supported format)
> * 0.7-1.0: "PCR-10:"
> 
> NOTE: we ignore evmctl failure for evmctl < 1.3.1 (missing --ignore-violations,
> also evmctl < 1.1 fails with "PCRAgg does not match PCR-10")
> 
> As for previous commit fix testing with TPM 2.0 device which does not
> export event log (/sys/kernel/security/tpm0/binary_bios_measurements):
> not wrongly assuming TPM-bypass when kernel didn't export other TPM
> 2.0 files we check in get_tpm_version() but bios boot aggregate is
> correct (i.e. not 0x00s). In that case evmctl ima_boot_aggregate can get
> boot aggregate even without TPM event log.
> 
> [1] https://patchwork.kernel.org/patch/11759729/
> 
> Co-developed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Thanks, Petr!

Other than the typo below, it looks good.

Mimi


> +test2()
>  {
> -	tst_res TINFO "verify PCR (Process Control Register)"
> +	local hash pcr_aggregate out ret
>  
> -	local dev_pcrs="$1"
> -	local pcr hash aggregate_pcr
> +	tst_res TINFO "verify PCR values"
>  
> -	aggregate_pcr="$(evmctl -v ima_measurement $BINARY_MEASUREMENTS 2>&1 | \
> -		grep 'HW PCR-10:' | awk '{print $3}')"
> -	if [ -z "$aggregate_pcr" ]; then
> -		tst_res TFAIL "failed to get PCR-10"
> -		return 1
> +	if [ "$MAYBE_TPM2" = 1 ]; then
> +		tst_res TINFO "TMP version not detected ($ERRMSG_TPM), assume TPM 2"


^ TPM  above and below

> +		TPM_VERSION=2
>  	fi
>  
> -	while read line; do
> -		pcr="$(echo $line | cut -d':' -f1)"
> -		if [ "$pcr" = "PCR-10" ]; then
> -			hash="$(echo $line | cut -d':' -f2 | awk '{ gsub (" ", "", $0); print tolower($0) }')"
> -			[ "$hash" = "$aggregate_pcr" ]
> -			return $?
> -		fi
> -	done < $dev_pcrs
> -	return 1
> -}
> +	if [ -z "$TPM_VERSION" ]; then
> +		tst_brk TCONF "TMP version not detected ($ERRMSG_TPM)"

 and here

