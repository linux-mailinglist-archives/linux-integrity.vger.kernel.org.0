Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C79B24597C
	for <lists+linux-integrity@lfdr.de>; Sun, 16 Aug 2020 22:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgHPUcY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 16 Aug 2020 16:32:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51494 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726331AbgHPUcY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 16 Aug 2020 16:32:24 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07GK3JR8192436;
        Sun, 16 Aug 2020 16:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=DyCoVDIe0RGK+DXW0JRk90Zuz9mjlGWfZ4AwNs0BSVE=;
 b=NDLzFgsw5yyIa4cm/3WKcbicP9bYoP/Ho6BQPIsFqoTgcbgD3XzQ77FMcU577b85vhTg
 IqJC8p9yk9KrcgH38Mw6Eq28W9lSLZLnonkPmkFQMZLdiK7HHmvzkfaN2udgJ4kY+04A
 s4lAqV4C3ARIPCY71kS0qfSLKNTPpvGzw6t66w9yZULMT/6C9CTpPV8+2SdBDc23BfLK
 0CZibanBta5oixiMXP88syFgpShb5U4+D1Hk4uvq5eZ7r/VcyVKP3w27WDbP378Gc5MS
 UP/N+wXfRO0LMaTo7SD5KV2svQq/u92UAFT8O3uR51CyUphj10d5K/gnZPs6dXiTFEyV Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32y4kw7g40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Aug 2020 16:32:19 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07GK4ZoU194407;
        Sun, 16 Aug 2020 16:32:19 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32y4kw7g3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Aug 2020 16:32:19 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07GKWH8v028601;
        Sun, 16 Aug 2020 20:32:17 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 32x6ygsg4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Aug 2020 20:32:17 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07GKWF5P61604172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Aug 2020 20:32:15 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18C0152050;
        Sun, 16 Aug 2020 20:32:15 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.65.247])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 927EE5204F;
        Sun, 16 Aug 2020 20:32:13 +0000 (GMT)
Message-ID: <d631253ca491bcdfe48ebd68a5acf7f26d75fb22.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils][PATCH] Install the swtpm package, if available
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>,
        Bruno Meneguele <bmeneg@redhat.com>
Date:   Sun, 16 Aug 2020 16:32:12 -0400
In-Reply-To: <20200816193627.73935-1-zohar@linux.ibm.com>
References: <20200816193627.73935-1-zohar@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-16_09:2020-08-14,2020-08-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=842
 mlxscore=0 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008160166
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2020-08-16 at 15:36 -0400, Mimi Zohar wrote:
>  # Only stop this test's software TPM.  Preferred method: "tsstpmcmd -stop"
> @@ -48,22 +52,36 @@ cleanup() {
>  
>  # Try to start a software TPM if needed.
>  swtpm_start() {
> -       local swtpm
> +       local swtpm swtpm1
>  
>         swtpm="$(which tpm_server)"
> -       if [ -z "${swtpm}" ]; then
> -               echo "${CYAN}SKIP: Softare TPM (tpm_server) not found${NORM}"
> +       swtpm1="$(which swtpm)"
> +       if [ -z "${swtpm}" ] && [ -z "${swptm1}" ]; then

Need to fix "swptm1" typo.

Mimi

> +               echo "${CYAN}SKIP: Softare TPM (tpm_server and swtpm) not found${NORM}"
>                 return "$SKIP"
>         fi


