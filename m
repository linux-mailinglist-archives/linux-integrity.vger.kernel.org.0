Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA6727F830
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Oct 2020 05:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgJADcb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Sep 2020 23:32:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbgJADca (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Sep 2020 23:32:30 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0913VuwM133167;
        Wed, 30 Sep 2020 23:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=KowU7UeaTMRvSx6ar6ifxL4UGWL2NjkBx9pfovmyXW8=;
 b=YJ9ZGMJ2UONJrgUE098fuOPdXFGqBFIFYnoGzbQGKC0XqEtRh3GGERE5uwPWqClNyewn
 kX/qkjNJ30hlXZif8pPMJF8ijUWDdMUGLNzae01gavaYdA7r2ZdbRz10zv5BBq6lQdTO
 8V5hzLVFj54vSKAWCdSff05a9XfDG0lwksiaehkwqT1F8iEWb3CJTI6Hs9P5FGqi3QjN
 KDql1DmvlXcakbPyHEnRFS+EZFYG/3ZJRdgeJuBTG/HxTkjGAkQZm5/i0mnIOxnoSu6z
 Wl+LHUO8ZYoidxcbzWnM4dLX3vwukcArjQ8yvv1P/WFHoOaP72ULTXgIoAujwVBRwhP3 qQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33w72x087u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 23:32:24 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0913VWMQ024532;
        Thu, 1 Oct 2020 03:32:22 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 33sw985250-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Oct 2020 03:32:21 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0913WJYm27197900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Oct 2020 03:32:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A82DDA4051;
        Thu,  1 Oct 2020 03:32:19 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56AE9A4057;
        Thu,  1 Oct 2020 03:32:18 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.36.232])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  1 Oct 2020 03:32:18 +0000 (GMT)
Message-ID: <b10815a3a0abade8ec8872757ab5ac2a4f7839f4.camel@linux.ibm.com>
Subject: Re: [PATCH v4 4/4] ima_tpm.sh: Fix calculating PCR aggregate
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 30 Sep 2020 23:32:17 -0400
In-Reply-To: <20200930160214.29358-5-pvorel@suse.cz>
References: <20200930160214.29358-1-pvorel@suse.cz>
         <20200930160214.29358-5-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_02:2020-09-30,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010010025
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-09-30 at 18:02 +0200, Petr Vorel wrote:

<snip>

> +get_pcr10_aggregate()
> +{
> +	local params pcr
> +	local msg="$ERRMSG_EVMCTL"
> +	local res=TCONF
> +
> +	if [ -z "$MISSING_EVMCTL" ]; then
> +		params="--ignore-violations"  <=== 

Violations should cause the measurement list verification to fail.

> +		msg=
> +		res=TFAIL
> +	elif check_ima_policy_cmdline "tcb"; then
> +		tst_res TCONF "using builtin IMA TCB policy $ERRMSG_EVMCTL"
> +		return
> +	fi
> +
> +	evmctl -v ima_measurement $params $BINARY_MEASUREMENTS > hash.txt 2>&1
> +	if [ $? -ne 0 -a -z "$MISSING_EVMCTL" ]; then
> +		tst_res TFAIL "evmctl failed $ERRMSG_EVMCTL"
> +		tst_res TINFO "hash file:"
> +		cat hash.txt >&2
> +		return
> +	fi
> +
> +	pcr=$(grep -E "^($ALGORITHM: )*PCRAgg.*:" hash.txt \

The IMA measurement list may contain records for other PCR 10.  The
output may contain other PCRs.  Using "PCRAgg.*10:" is safer.  
Probably need to use "grep -m 1 -E" as well.

thanks,

Mimi

> +		| awk '{print $NF}')
> +
> +	if [ -z "$pcr" ]; then
> +		tst_res $res "failed to find aggregate PCR-10 $msg"
> +		tst_res TINFO "hash file:"
> +		cat hash.txt >&2
> +		return
> +	fi
> +
> +	echo "$pcr"
> +}
> +




