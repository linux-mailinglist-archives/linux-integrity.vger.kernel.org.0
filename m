Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A5332B328
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Mar 2021 04:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhCCB3n (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Mar 2021 20:29:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351091AbhCBNbd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Mar 2021 08:31:33 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 122DLAnh019792;
        Tue, 2 Mar 2021 08:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=o5Z9y33maAEhv+LN3/ehy6YtXs7A81xGJs4Xc3UM8Us=;
 b=VllA/SWXS8Sfpw7ry0WweQ6x2ljzTXD9dvJJsPlz0KSxXOSfY+Uho2M+xcWUKj0KbYcv
 Je18Btazt5UU0K7v4heRYP/YDmKTbEdyOOFa6TgZFSxCxG/uGMYs6AgQ5wBiTnOrnTSF
 A8vxDGAYnfPPusHCvTh5YBj0VGg0fXp/4ZumJ9ZfA/3R26tilmfxt0sJFGiOgE3Ck5NG
 D5G/UQGJjr0ozrBlHNiJ6h2k14U7Hf1Rjg9EcO9Eqquorm9m3v9KJrXJqEp3d6ljEzHP
 ofuw5Rpi5Royrs/OuxMsuB1fig89tQwCKN5N8tE9jmEb4PYDHIQSVPw6oF7kY1YdUqiz 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 371p5yg6v5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 08:30:07 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 122DMnWF023013;
        Tue, 2 Mar 2021 08:30:06 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 371p5yg6sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 08:30:06 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 122DMuc2031303;
        Tue, 2 Mar 2021 13:30:04 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 370c59sx1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 13:30:03 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 122DU1wl50856288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Mar 2021 13:30:01 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFC94AE058;
        Tue,  2 Mar 2021 13:30:01 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12BDBAE051;
        Tue,  2 Mar 2021 13:30:00 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.103.165])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  2 Mar 2021 13:29:59 +0000 (GMT)
Message-ID: <1a679c59345b02f10e425c8c5c55efd901dc714d.camel@linux.ibm.com>
Subject: Re: [PATCH 06/20] ima: Manual replacement of the deprecated
 strlcpy() with return values
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Romain Perier <romain.perier@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 02 Mar 2021 08:29:58 -0500
In-Reply-To: <20210222151231.22572-7-romain.perier@gmail.com>
References: <20210222151231.22572-1-romain.perier@gmail.com>
         <20210222151231.22572-7-romain.perier@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_06:2021-03-01,2021-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020107
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-02-22 at 16:12 +0100, Romain Perier wrote:
> The strlcpy() reads the entire source buffer first, it is dangerous if
> the source buffer lenght is unbounded or possibility non NULL-terminated.

As other's have pointed out, "lenght" -> length.

> It can lead to linear read overflows, crashes, etc...
> 
> As recommended in the deprecated interfaces [1], it should be replaced
> by strscpy.
> 
> This commit replaces all calls to strlcpy that handle the return values
> by the corresponding strscpy calls with new handling of the return
> values (as it is quite different between the two functions).
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  security/integrity/ima/ima_policy.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 9b45d064a87d..1a905b8b064f 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -790,8 +790,14 @@ static int __init ima_init_arch_policy(void)
>  	for (rules = arch_rules, i = 0; *rules != NULL; rules++) {
>  		char rule[255];
>  		int result;
> +		ssize_t len;
>  
> -		result = strlcpy(rule, *rules, sizeof(rule));
> +		len = strscpy(rule, *rules, sizeof(rule));
> +		if (len == -E2BIG) {
> +			pr_warn("Internal copy of architecture policy rule '%s' "
> +				"failed. Skipping.\n", *rules);

"arch_rules" is an array of hard coded strings.   The generic reason
for replacing strlcpy with strscpy doesn't seem applicable; however,
the additonal warning is appropriate.

(User-visible strings are not bound to the 80 column length.  Breaking
up the line like this is fine, but unnecessary.)

Acked-by: Mimi Zohar <zohar@linux.ibm.com>

thanks,

Mimi

> +			continue;
> +		}
>  
>  		INIT_LIST_HEAD(&arch_policy_entry[i].list);
>  		result = ima_parse_rule(rule, &arch_policy_entry[i]);
> 



