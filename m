Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93CC3B36FF
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jun 2021 21:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhFXTbZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Jun 2021 15:31:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232029AbhFXTbZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Jun 2021 15:31:25 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15OJ3ZYj006990;
        Thu, 24 Jun 2021 15:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=2alq+xPrCz2378F/yOYmBqAXfR2E6sSn8LhBlefpEKA=;
 b=aIX20DT0WCl/OJM1BDlxMuGe5Z4ocO4994J+55Wq+WTlLrC2KuybEVbV+opDqKyHekyg
 nVDd5AszBza63BOoO9LIANJmODG2IAzef8K0CmLe0nXzjGKgLW5GNDoE3azxZZTbFe8M
 fihd3RT7gfUUplcjEnXYqBppzniuSrEhaBnUJ0+avQPb5ZRyVZWEKhFtOUZ6cymZV/uP
 hkpNCBVDwdvVkW5ZVmFO/REHHOkc8aw0H1v9ilH5vpjfOwsGOViV8Juwre+XCJXgSfst
 17YYOMAk3AV69GRaKJvaZ2kriH5avGqpdh/rTE5F3eH7+SjCXCpgnHYttavYl8KktG4j OA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39cy75t0qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 15:29:03 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15OJSDCS024623;
        Thu, 24 Jun 2021 19:29:01 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 399878aq3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 19:29:00 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15OJSwJd31129948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 19:28:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 849FB4C044;
        Thu, 24 Jun 2021 19:28:58 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3EF54C040;
        Thu, 24 Jun 2021 19:28:57 +0000 (GMT)
Received: from sig-9-65-196-119.ibm.com (unknown [9.65.196.119])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 24 Jun 2021 19:28:57 +0000 (GMT)
Message-ID: <ba047a635f5f9a2db14e3496eafcf194ad9058cd.camel@linux.ibm.com>
Subject: Re: [PATCH 0/3] Add GitHub Actions support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Date:   Thu, 24 Jun 2021 15:28:56 -0400
In-Reply-To: <YNHv/oTp7/8rH7sc@pevik>
References: <20210622141224.25006-1-pvorel@suse.cz> <YNHv/oTp7/8rH7sc@pevik>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Zd2nucFp86uRYzYRLL8crD3KryoYSqqS
X-Proofpoint-GUID: Zd2nucFp86uRYzYRLL8crD3KryoYSqqS
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-24_12:2021-06-24,2021-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106240105
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-06-22 at 16:13 +0200, Petr Vorel wrote:
> Hi Mimi,
> 
> Tested: https://github.com/pevik/ima-evm-utils/actions/runs/960841012

Thanks!

