Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC6E268224
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Sep 2020 02:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgINAac (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 13 Sep 2020 20:30:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725975AbgINAab (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 Sep 2020 20:30:31 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08E016K2108893;
        Sun, 13 Sep 2020 20:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=6rpQKDBRuIsbrrjSBKoysTXauzO2k4t35aj1AEiGdJg=;
 b=SQAE+eIUg1zrPKIW4g+M0JLIc81riBxBwJJbQseCtcC9fmzwNtRSQTSXJh1VyT4SGxKQ
 sQYKj2DNjKRZ8floHqHsZzMLbb9aLDa3ejU0gHBEXnfp/JTAc+tB3PBfbnPds29+X5rw
 lnr+JDUZxJrjhhlRJPS00CPuBLiq0BimDgrmpvhCNOxppCLCBijgbZNV0v9FhUAxOq0A
 JCIfFiUpPKpXk0VMk1AnwYNvoQiEl114ElXCGUYd5jPTyqcXsNhobNlYpNcYnieL5DqR
 BEAyEl2t2idl3W/hWC53smw2b2ywfWOqh1wrxH7E5LBuwgY5K8mECfZuXDFNpf7Z19ML WA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33hw0w8xy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Sep 2020 20:30:28 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08E0E7HW139485;
        Sun, 13 Sep 2020 20:30:28 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33hw0w8xxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Sep 2020 20:30:28 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08E0TQpO015326;
        Mon, 14 Sep 2020 00:30:26 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 33gny89pxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 00:30:26 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08E0UOiV9699712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Sep 2020 00:30:24 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 318C011C04C;
        Mon, 14 Sep 2020 00:30:24 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDCC111C050;
        Mon, 14 Sep 2020 00:30:22 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.109.217])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Sep 2020 00:30:22 +0000 (GMT)
Message-ID: <47701fa4bf0171354e90feba1b13186278b61fd9.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] ima-evm-utils: Add test for sigfile reading
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Sun, 13 Sep 2020 20:30:21 -0400
In-Reply-To: <20200912193614.12903-2-vt@altlinux.org>
References: <20200912193614.12903-1-vt@altlinux.org>
         <20200912193614.12903-2-vt@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-13_09:2020-09-10,2020-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 spamscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009130218
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2020-09-12 at 22:36 +0300, Vitaly Chikunov wrote:
> Test reading of detached IMA signature (--sigfile).
> 
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

Thanks,

Mimi

> ---
>  tests/sign_verify.test | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/sign_verify.test b/tests/sign_verify.test
> index 118c3f6..cddeb15 100755
> --- a/tests/sign_verify.test
> +++ b/tests/sign_verify.test
> @@ -93,7 +93,8 @@ _test_sigfile() {
>      return "$FAIL"
>    fi
>  
> -  rm "$file_sig" "$file_sig2"
> +  # Leave '$file_sig' for ima_verify --sigfile test.
> +  rm "$file_sig2"
>  }
>  
>  # Run single sign command
> @@ -254,9 +255,12 @@ sign_verify() {
>  
>      # Normal verify with proper key should pass
>      expect_pass check_verify
> +    expect_pass check_verify OPTS="--sigfile"
>  
>      # Multiple files and some don't verify
>      expect_fail check_verify FILE="/dev/null $file"
> +
> +    rm "$FILE.sig"
>    fi
>  
>    TYPE=evm


