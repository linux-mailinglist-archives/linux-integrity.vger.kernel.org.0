Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CB12ECF91
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jan 2021 13:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbhAGMZm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jan 2021 07:25:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727753AbhAGMZm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jan 2021 07:25:42 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 107C6lsg030965;
        Thu, 7 Jan 2021 07:24:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=9PeZe8VbTahr2/DVWMrRzj3NqETwZ/pDwfE1YqGtEQQ=;
 b=lvpCTCt0hg3zkC8gUzKN8NMqYk4iqh8QFuGbTGVZ9DfkIR9XbCgOUgMgXk6nAhN8dRfh
 FrDoKrM7ItgpvW9ZKtA+U0wm7kgX75JUbVhHt9J/RgCOIwyXtTcHQNNQOJ5/X+pxWtTb
 NZzBFU1+GCeMVjmCCFGioDv7/rbHBziTyc9HxP9tkrCpT9RHBqYciiNDE0PqKZHN5H0M
 GUjFjbJgl5nSQKP9MLHfx3KEoT6dz4rceK+h71/1GuNcxPq57TtmihH/vq2HLtyC0HDX
 Iq20Fsb4R63kMJ5MgmnJZ9G9LKsIO84zGD/oiR1b3O5gzCfaWtY2MkX/7aQrsgH2XHl6 Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35x1wfrpyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 07:24:53 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 107C6obe031113;
        Thu, 7 Jan 2021 07:24:51 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35x1wfrpx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 07:24:50 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 107C8UHh014528;
        Thu, 7 Jan 2021 12:24:47 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 35tgf8cu7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 12:24:47 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 107COf5I7012612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jan 2021 12:24:41 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D02BAE045;
        Thu,  7 Jan 2021 12:24:45 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 492E4AE053;
        Thu,  7 Jan 2021 12:24:44 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.37.241])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jan 2021 12:24:44 +0000 (GMT)
Message-ID: <ed6980130453e529d5bc8a089a0d0082d2f471cd.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] Fix sign_hash not observing the hashalgo argument
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Patrick Uiterwijk <patrick@puiterwijk.org>,
        linux-integrity@vger.kernel.org
Cc:     pbrobinson@redhat.com, Vitaly Chikunov <vt@altlinux.org>
Date:   Thu, 07 Jan 2021 07:24:43 -0500
In-Reply-To: <20210106094335.3178261-2-patrick@puiterwijk.org>
References: <20210106094335.3178261-1-patrick@puiterwijk.org>
         <20210106094335.3178261-2-patrick@puiterwijk.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-07_05:2021-01-07,2021-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101070075
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Patrick,

On Wed, 2021-01-06 at 10:43 +0100, Patrick Uiterwijk wrote:
> This fixes sign_hash not using the correct algorithm for creating the
> signature, by ensuring it uses the passed in variable value.
> 
> Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>

Thank you.  This is a regression first introduced in commit
07e623b60848 ("ima-evm-utils: Convert sign_hash_v2 to EVP_PKEY API").

Mimi

