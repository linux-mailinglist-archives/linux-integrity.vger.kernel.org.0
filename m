Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4F5310B11
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Feb 2021 13:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhBEM2K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Feb 2021 07:28:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29544 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232046AbhBEMZh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Feb 2021 07:25:37 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 115C3GPJ130347;
        Fri, 5 Feb 2021 07:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=UXMTnONaM1M6hPx6NdQOBybyrZ8DbchDfplowPWQEDo=;
 b=TqePX8K6Tyu+ITrsknKNyn3o8sz0j2weSoIEzb0UQb1tAHBuzDJw0YI1bP/gq5iBeaj+
 qleHcXYkpklEDQEjOQ9F9IMLNVyn8d0RZfPVgtkGULf3NAX693GtML/6B35jLSpmRSLb
 fSXuDA4eylD7ytGs+M3m9QddKC3KHdUneyuI/ILS6fIvv8ksvjYJDuv4VXblK3sg6A7F
 pEDWg90Vjw8wbrxrHz3BQxLKJWqC8f/hbrjDy25w6eU8JRjsE3jfb8iKIXj7XfBOyUhB
 mqhHWy64Gjt2yQehAmGjbaP0wVZ4294O0tiiqQIkKJc1t/NerLsvM29Wb6niG08YFmgX 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36h5n90twh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Feb 2021 07:24:45 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 115C4NsH138342;
        Fri, 5 Feb 2021 07:24:44 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36h5n90tvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Feb 2021 07:24:44 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 115CCvka002358;
        Fri, 5 Feb 2021 12:24:42 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 36cy38nw77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Feb 2021 12:24:42 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 115COU5137224878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Feb 2021 12:24:30 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E09E942041;
        Fri,  5 Feb 2021 12:24:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28E824203F;
        Fri,  5 Feb 2021 12:24:37 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.9.149])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  5 Feb 2021 12:24:36 +0000 (GMT)
Message-ID: <5cb27bdb74e394a9048af702a7d8acfa181b4d9b.camel@linux.ibm.com>
Subject: Re: [PATCH v7 4/4] ima: Support EC keys for signature verification
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        herbert@gondor.apana.org.au, dhowells@redhat.com
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date:   Fri, 05 Feb 2021 07:24:36 -0500
In-Reply-To: <20210201151910.1465705-5-stefanb@linux.ibm.com>
References: <20210201151910.1465705-1-stefanb@linux.ibm.com>
         <20210201151910.1465705-5-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_06:2021-02-05,2021-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050076
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-02-01 at 10:19 -0500, Stefan Berger wrote:
> Add support for IMA signature verification for EC keys. Since SHA type
> of hashes can be used by RSA and ECDSA signature schemes we need to
> look at the key and derive from the key which signature scheme to use.
> Since this can be applied to all types of keys, we change the selection
> of the encoding type to be driven by the key's signature scheme rather
> than by the hash type.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Vitaly Chikunov <vt@altlinux.org>
> Reviewed-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Thanks, Stefan!

Acked-by: Mimi Zohar <zohar@linux.ibm.com>

