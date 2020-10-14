Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28A328E8A1
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Oct 2020 00:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgJNWEX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Oct 2020 18:04:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31182 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725899AbgJNWEW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Oct 2020 18:04:22 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09EM2B0U194021;
        Wed, 14 Oct 2020 18:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=BaHcCpd0WNFwP3sbRAoTB+rhNbbg4Cte849TTcSlHis=;
 b=IxeTvBwFQej7hASGLcUj4A+v2MaBv/i0aqU20rPd6gE+1xoAzoIvy8t2Lky77pFvGjzg
 dvaqHL7W2ohgyObSLhoDTozBiIvcwo7pw+U0kxnnB5BFp7rJBOvH36aMIg9bwuI2s5g6
 icgOA6++y9ZdjVsHL8x68UBgW5copNfrSyCiS9RmdueUV3SA0NvpqBkcn4tE+ZUi2vnn
 09JIb1c7UR0O6JW7X76IEK+YLWe3A3lmSHM64gQUyui45/tHEXyAHXc2atiOGRckaLOE
 X7jcHhE3BivIUC//rdllSBAnnUObv1ZC0GF1bZMQYxy1T5cIKRilyPXO6MdgP7GwGNZ3 Lw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3469670wdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 18:04:19 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09ELqxiL009632;
        Wed, 14 Oct 2020 22:04:18 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3434k84k4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 22:04:17 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09EM4Frr19399086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 22:04:15 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1B804C059;
        Wed, 14 Oct 2020 22:04:15 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3ED04C040;
        Wed, 14 Oct 2020 22:04:14 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.12.97])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Oct 2020 22:04:14 +0000 (GMT)
Message-ID: <ac8d885af1f79a8d1e2c137654b9924693b328b1.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/5] ima-evm-utils: Change env variable
 TPM_SERVER_TYPE for tpm_server
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ken Goldman <kgoldman@us.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>
Cc:     Petr Vorel <pvorel@suse.cz>
Date:   Wed, 14 Oct 2020 18:04:13 -0400
In-Reply-To: <20201012234416.20995-2-kgoldman@us.ibm.com>
References: <20201012234416.20995-1-kgoldman@us.ibm.com>
         <20201012234416.20995-2-kgoldman@us.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-14_12:2020-10-14,2020-10-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010140149
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Ken,

On Mon, 2020-10-12 at 19:44 -0400, Ken Goldman wrote:
> The default value raw is appropriate for 'swtpm'.  tpm_server
> uses the Microsoft packet encapsulation, so the env variable
> must have the value mssim.
> 
> Signed-off-by: Ken Goldman <kgoldman@us.ibm.com>

Thank you for noticing this regression.

> ---
>  tests/boot_aggregate.test | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
> index 1c7b1f2..b109a32 100755
> --- a/tests/boot_aggregate.test
> +++ b/tests/boot_aggregate.test
> @@ -35,6 +35,7 @@ else
>  	export TPM_COMMAND_PORT=2321
>  	export TPM_PLATFORM_PORT=2322
>  	export TPM_SERVER_NAME="localhost"
> +	# swtpm uses the raw, unencapsulated packet format
>  	export TPM_SERVER_TYPE="raw"

Instead of adding a comment here, how about only exporting
TPM_SERVER_TYPE for "swtpm".

>  
>  fi
> @@ -73,6 +74,8 @@ swtpm_start() {
>  			SWTPM_PPID=$!
>  		fi
>  	elif [ -n "${swtpm}" ]; then
> +	        # tpm_server uses the Microsoft simulator encapsulated packet format
> +                export TPM_SERVER_TYPE="mssim"

Exporting TPM_SERVER_TYPE like this is causing openssl/tumbleweed to
fail.

thanks,

Mimi

>  		pgrep swtpm
>  		if [ $? -eq 0 ]; then
>  			echo "INFO: Software TPM (tpm_server) already running"


