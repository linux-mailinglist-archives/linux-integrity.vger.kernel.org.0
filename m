Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13694405E96
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Sep 2021 23:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345722AbhIIVIT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Sep 2021 17:08:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30236 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234040AbhIIVIR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Sep 2021 17:08:17 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 189L71oR053288;
        Thu, 9 Sep 2021 17:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=SBW/OuKgZl8hxUpHuPnNdTORhmOMWUu9SAim18yUnPg=;
 b=JU+Nl69BBVYk/oOF5VA2MDTCnwZbyiVU5ero8zjkiwCXcf0Zwm/roFdO24yMQgesDI9T
 IkXykeNx9Tj8Hwn96FFpXnCpziJLQ4yPIbrIbGgBV9vg0Kc8NnrycOPzO0Vuf4YQ+mln
 jVaxGuwn/YmyS8t/DDkT3Z6ConeQCsqbzXpaBHnthf1TdCPxmyB7ylRgOfirGM1ctTdN
 Qlv5ZrpVtyUYBW9PsgZDWJ/AYSAU74uokHhk8oPj+s4vwX2V8qJQirzb5pogC/GkeGJV
 nRR14JAp7N529tztsELdzoGiB9oJL9OJE8k4+nhfhQyDIz406+f/4Ubv23lfVagn7qBB jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ay9yngjnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 17:07:07 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 189L76CR053896;
        Thu, 9 Sep 2021 17:07:06 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ay9yngj2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 17:07:06 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 189L3ejL028763;
        Thu, 9 Sep 2021 21:03:47 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3axcnptkuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 21:03:46 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 189L3io413631928
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Sep 2021 21:03:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CDC2A4534;
        Thu,  9 Sep 2021 21:03:44 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD9B9A44EC;
        Thu,  9 Sep 2021 21:03:42 +0000 (GMT)
Received: from sig-9-65-72-231.ibm.com (unknown [9.65.72.231])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Sep 2021 21:03:42 +0000 (GMT)
Message-ID: <ab238b241d1328c3933681b8b939b5e5a9288aaf.camel@linux.ibm.com>
Subject: Re: [PATCH v5 ima-evm-utils 1/2] set default hash algorithm in
 configuration time
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Bruno Meneguele <bmeneg@redhat.com>, Simon.THOBY@viveris.fr,
        kgold@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org
Date:   Thu, 09 Sep 2021 17:03:41 -0400
In-Reply-To: <20210902192427.314337-2-bmeneg@redhat.com>
References: <20210902192427.314337-1-bmeneg@redhat.com>
         <20210902192427.314337-2-bmeneg@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EQfAtXffl0FtiY686fAGgdIQjuCdZHLD
X-Proofpoint-ORIG-GUID: 4Ahgsv9FDSPOpzRqIn7xqmYYOtMgSFvN
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-09_07:2021-09-09,2021-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090129
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-09-02 at 16:24 -0300, Bruno Meneguele wrote:
> +       AC_ARG_WITH([default_hash],
> +               AS_HELP_STRING([--with-default-hash=ALGORITHM], [specifies the default hash algorithm to be used]),
> +               [HASH_ALGO=$withval],
> +               [HASH_ALGO=sha1])
> +
> +       AC_CHECK_HEADER([$HASH_INFO_HEADER],
> +               [HAVE_HASH_INFO_HEADER=yes],
> +               [AC_MSG_WARN([$HASH_INFO_HEADER not found.])])
> +
> +       if test "x$HAVE_HASH_INFO_HEADER" = "x"; then
> +               AC_MSG_RESULT([using $HASH_ALGO algorithm as default hash algorith])
> +               AC_DEFINE_UNQUOTED(DEFAULT_HASH_ALGO, "$HASH_ALGO", [Define default hash algorithm])
> +       else
> +               AC_PROG_SED()
> +               AC_PROG_GREP()
> +               $SED -n 's/HASH_ALGO_\(.*\),/\L\1\E/p' $HASH_INFO_HEADER | $GREP -w -i $HASH_ALGO > /dev/null

This does an a case insensitive test for the hash algorithm, but the
code itself doesn't support upper case hash algorithms (e.g. SHA1,
SHA256).

thanks,

Mimi


> +               have_hash=$?
> +
> +               if test $have_hash -ne 0; then
> +                       AC_MSG_ERROR([$HASH_ALGO algorithm specified, but not provided by the kernel], 1)
> +               else
> +                       AC_MSG_NOTICE([using $HASH_ALGO as default hash algorithm])
> +                       AC_DEFINE_UNQUOTED(DEFAULT_HASH_ALGO, "$HASH_ALGO", [Define default hash algorithm])
> +               fi


