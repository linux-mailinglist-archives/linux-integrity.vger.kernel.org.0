Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E75B3E93F7
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Aug 2021 16:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhHKOwd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 10:52:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232370AbhHKOwd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 10:52:33 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17BEord6090522;
        Wed, 11 Aug 2021 10:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=EqW0Zu+u/blbm0FmHgQjOFllnl/TNm0XUq6MLBIIE/8=;
 b=bvirWdHclyMg+zYdB9LvojI28VR5hIm37L6FrZYFj+6fdJPZacOwqtbJpTYd8PxgAv3z
 nNnyf3TbdMMCXAJYw8EkbNC7TkayLTEYlDMQbX95dTZ/VSE3qt2WqkoR4q5421GEs8rb
 OePsXdodRKpeM3ryz5GwlsJXpFSS2ROfcKUmVDlWKyZ5NeW3H/6BpeN73k50yr6KwpSJ
 A+CbE9IBtjyWW4quOurKrCxwfiu209VLK2AWDITkwOinqLkTWaiK7ncJK3NKzpqgJWtn
 YUp9hRh6ZkYjlCQsCm1KsncDcJ6ZdWmvd9gLj3NNYYPAF/xBt0nhRnztP3WxvO0Fz4Hj /w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3abt14k2yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 10:52:07 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17BEpvgk093867;
        Wed, 11 Aug 2021 10:52:07 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3abt14k2xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 10:52:06 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17BEgkbp015634;
        Wed, 11 Aug 2021 14:52:05 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3abaq4b3ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 14:52:05 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17BEq2ZD28049750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 14:52:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C172A4065;
        Wed, 11 Aug 2021 14:52:02 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6DBDA405C;
        Wed, 11 Aug 2021 14:52:01 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.27.84])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 Aug 2021 14:52:01 +0000 (GMT)
Message-ID: <cf5349dc43b2e8efc709abcf8e1637b7da692bee.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] evmctl: fix memory leak in get_password
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Bruno Meneguele <bmeneg@redhat.com>, vt@altlinux.org
Cc:     linux-integrity@vger.kernel.org
Date:   Wed, 11 Aug 2021 10:52:00 -0400
In-Reply-To: <20210810202852.236354-1-bmeneg@redhat.com>
References: <20210810202852.236354-1-bmeneg@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jAQg5lmJz0cbiUQee5t9wv7qvvS9lhXo
X-Proofpoint-GUID: flKxSt5oQpIRqc-Pu8Q8IEvJNX-ZSo9i
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-11_05:2021-08-11,2021-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108110098
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Bruno,

On Tue, 2021-08-10 at 17:28 -0300, Bruno Meneguele wrote:
> The variable "password" is not freed nor returned in case get_password()
> succeeds. Instead of using an intermediary variable ("pwd") for returning
> the value, use the same "password" var. Issue found by Coverity scan tool.
> 
> src/evmctl.c:2565: leaked_storage: Variable "password" going out of scope
>     leaks the storage it points to.
> 
> Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
> ---
>  src/evmctl.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 7a6f2021aa92..b49c7910a4a7 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -2601,8 +2601,9 @@ static struct option opts[] = {
>  static char *get_password(void)
>  {
>  	struct termios flags, tmp_flags;
> -	char *password, *pwd;
> +	char *password;
>  	int passlen = 64;
> +	bool err = false;
>  
>  	password = malloc(passlen);
>  	if (!password) {
> @@ -2622,16 +2623,24 @@ static char *get_password(void)
>  	}
>  
>  	printf("PEM password: ");
> -	pwd = fgets(password, passlen, stdin);
> +	if (fgets(password, passlen, stdin) == NULL) {
> +		perror("fgets");
> +		/* we still need to restore the terminal */
> +		err = true;
> +	}

From the fgets manpage: 
   fgets() returns s on success, and NULL on error
   or  when  end  of  file
   occurs while no characters have been read. 

>  	/* restore terminal */
>  	if (tcsetattr(fileno(stdin), TCSANOW, &flags) != 0) {
>  		perror("tcsetattr");
> +		err = true;
> +	}
> +
> +	if (err) {
>  		free(password);
>  		return NULL;
>  	}
> 
> -	return pwd;
> +	return password;

Wouldn't a simpler fix be to test "pwd" here?
        if (!pwd)
                free(password);
        return pwd;

thanks,

Mimi

>  }
>  
>  int main(int argc, char *argv[])


