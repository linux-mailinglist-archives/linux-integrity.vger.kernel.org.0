Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CB631A4AC
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Feb 2021 19:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhBLSqH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Feb 2021 13:46:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231289AbhBLSqG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Feb 2021 13:46:06 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11CIZMCm101262
        for <linux-integrity@vger.kernel.org>; Fri, 12 Feb 2021 13:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=FFGrOoBA093NGFN5tXf7L8J8+9DyhwAhu0ewRvhCI9Q=;
 b=hU5y5IY6V0pcimSis0HYwn4f7qC84cYqGfR1zkxIKJjkpgGahxiEeUKJNQjqJ6ebxeQ3
 ZdwptyQPesJK6nKn+DvmGKQB87z7xfSoy2rT/R2JLxqh7+nhkwiIoIQ8enpN6uW2/BYI
 jFK0gJ4jj8qBLhyInZEvav5AhKVpKPNev3mhaboexH2ixtapdtORW5d1gl+lzpCj9wI/
 5sKuMYgFx0TFkqEROV8Rp+VPYzg6vOGrEMsitMn92V/OhbjFGtZ/rVsN4lcDAaw4L0VN
 ibhQXlH2aKH2WdFHrxwyhb+/lrLVjvK9FYJYsXGqT2CKumKg2u/nDzJJj7/RAX8pF28O iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36nxyfrfkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 12 Feb 2021 13:45:24 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11CIZP0f101382
        for <linux-integrity@vger.kernel.org>; Fri, 12 Feb 2021 13:45:23 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36nxyfrfk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 13:45:23 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11CIfWbk002390;
        Fri, 12 Feb 2021 18:45:22 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 36j94wp6ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 18:45:21 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11CIjJFX53477822
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 18:45:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CADC842047;
        Fri, 12 Feb 2021 18:45:19 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DC354203F;
        Fri, 12 Feb 2021 18:45:19 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.53.37])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Feb 2021 18:45:18 +0000 (GMT)
Message-ID: <719b6c796614e46e2c19792b8a2dd374a336b9b3.camel@linux.ibm.com>
Subject: Re: [PATCH] ima-evm-utils: Prevent crash if pcr is invalid
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Frank Sorenson <sorenson@redhat.com>,
        linux-integrity@vger.kernel.org
Date:   Fri, 12 Feb 2021 13:45:17 -0500
In-Reply-To: <20210212175822.2917142-1-sorenson@redhat.com>
References: <20210212175822.2917142-1-sorenson@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-12_07:2021-02-12,2021-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120133
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-02-12 at 11:58 -0600, Frank Sorenson wrote:
> If the pcr is invalid, evmctl will crash while accessing
> an invalid memory address.  Verify the pcr is in the
> expected range.
> 
> Also, correct range of an existing check.
> 
> Signed-off-by: Frank Sorenson <sorenson@redhat.com>

Thanks, applied to next-testing.

Mimi

