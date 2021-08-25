Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B213F7DED
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Aug 2021 23:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhHYVop (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Aug 2021 17:44:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64762 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232768AbhHYVoo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Aug 2021 17:44:44 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17PLWp9Z103530;
        Wed, 25 Aug 2021 17:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=CRTbVI50PL/z/SKAGB5M+SZ5qh4vPwzcdWGFu+FBs8I=;
 b=WyTubZ4hO4Guv14EckbiBnW0xxIZ21xCMRx64C9Vc0CSVH9A3sTfxKiVQIpop4MymVeN
 rF5LMpGI3P2grSYbJ0AFjQ9XOZTcpWbPaWYfXqNPZp6TyzMegALn9IgEVAE1vORQpso2
 URcl/qAQmTm3c+thEwY6csaKRorR+NQbxoJygiztiokD8pJRv+Rsu9UTNBz7WISjwf1V
 SFt5Fvypg/Lvovi4hVnpNBoIuUt7yQdrLe5Pys289uEWGZRRaXCqDzA/XXFn+PNQaYgq
 +Lt16EutYcXYkQtWGlIeh8PoXZgYUlrMObfoNb8WtKsaCQrMc2vgB9A/KMIPJdTlLlS1 Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3anwkyrk1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Aug 2021 17:43:58 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17PLZAKC115676;
        Wed, 25 Aug 2021 17:43:57 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3anwkyrk0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Aug 2021 17:43:57 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17PLgvob030180;
        Wed, 25 Aug 2021 21:43:55 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3ajs4901xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Aug 2021 21:43:55 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17PLhqw952953466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 21:43:52 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63263A404D;
        Wed, 25 Aug 2021 21:43:52 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AB1AA4051;
        Wed, 25 Aug 2021 21:43:51 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.60.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 25 Aug 2021 21:43:50 +0000 (GMT)
Message-ID: <3ea0519200137128c67556b9c627a4849ddfbd24.camel@linux.ibm.com>
Subject: Re: [PATCH v4 ima-evm-utils 1/2] set default hash algorithm in
 configuration time
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Bruno Meneguele <bmeneg@redhat.com>, Simon.THOBY@viveris.fr,
        kgold@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org
Date:   Wed, 25 Aug 2021 17:43:50 -0400
In-Reply-To: <20210820230001.102249-2-bmeneg@redhat.com>
References: <20210820230001.102249-1-bmeneg@redhat.com>
         <20210820230001.102249-2-bmeneg@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8_kgRaucGZkhQw10A3IXVqVlri93O30l
X-Proofpoint-ORIG-GUID: 6OodpcT4EcuKBWc7NHlmQ_ZhMmtqtqoF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-25_08:2021-08-25,2021-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108250125
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Bruno,

On Fri, 2021-08-20 at 20:00 -0300, Bruno Meneguele wrote:
> The default hash algorithm for evmctl is today hardcoded libimaevm.c file.
> To facilitate different distributions and users to set their own default
> hash algorithm this patch adds the --with-default-hash=<algo> option to the
> configuration script.
> 
> The algorithm chosen by the user will then be checked if is available in the
> kernel, otherwise IMA won't be able to verify files hashed by the user. For
> that, the file exposed by the kernel crypto API (/proc/crypto) is filtered
> by an AWK script in order to check the algorithm's name and the module
> providing it. Initally, only "module: kernel" is accepted, following IMA's
> CONFIG_CRYPTO_SHA1/SHA256 dependency.

There's a difference between preventing an evmctl user from
unintentionally using an unsupported algorithm and the distro, or
whoever is building the package, defining the wrong default hash
algorithm.

My preference would be to allow any hash algorithm defined in
hash_info.h (kernel_headers package) as the default.

thanks,

Mimi

