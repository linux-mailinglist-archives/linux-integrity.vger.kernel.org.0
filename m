Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC2440000E
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Sep 2021 14:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349366AbhICM4v (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Sep 2021 08:56:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24604 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235211AbhICM4t (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Sep 2021 08:56:49 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 183CYEaf015285
        for <linux-integrity@vger.kernel.org>; Fri, 3 Sep 2021 08:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=kzNrgmkQb84yEUM/chqOY1ErDNWRafpcCEamFr4dU6s=;
 b=T+DwtwWa0Zz+nsMD2LFSff76q3cst86JxEeCntILF+cWOPsI4LfV9h2FvUWyOG2YhGi/
 IksfEBa5+Rlmi69U0hj5s9rG9P4hMqCx8o38e0sMb0EYOVxH4BaoaaSpbAJ0ZSmhB8NQ
 9Z3samvCrnyRpu1sAQPno76VzXZ2wDrbQodeRRGTe2JsYmwwIDQoL7CgzKgbesVoEEXv
 udQtBv9/+RtbPvVOYkUwp81waDcSBkcRa5nKF8KxpZB9NDpWOrWe8ssWSQ1VbbJplzVN
 0F8c1XUWWLv11bnMA0JU9uIWCjeAoaZccRLc5WJ6RahWX7JLfFf3yvDlZJF2Rp/u1KDI LQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aukrwgh32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Sep 2021 08:55:48 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 183CmFP6029860
        for <linux-integrity@vger.kernel.org>; Fri, 3 Sep 2021 12:55:46 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3au6q786gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Sep 2021 12:55:46 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 183CthE312255674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Sep 2021 12:55:43 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22897A4051;
        Fri,  3 Sep 2021 12:55:43 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57357A405D;
        Fri,  3 Sep 2021 12:55:42 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.38.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Sep 2021 12:55:42 +0000 (GMT)
Message-ID: <cac11911a82d161baaf3e466a8d8d9a314b9de47.camel@linux.ibm.com>
Subject: Re: [PATCH v2 4/8] evmctl: Extend libimaevm_params with ENGINE
 field and use it
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Date:   Fri, 03 Sep 2021 08:55:41 -0400
In-Reply-To: <20210810134557.2444863-5-stefanb@linux.vnet.ibm.com>
References: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
         <20210810134557.2444863-5-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xZBQ1FUpuGMag756iX3bAL0461_K5-Hb
X-Proofpoint-GUID: xZBQ1FUpuGMag756iX3bAL0461_K5-Hb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-03_03:2021-09-03,2021-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxscore=0 mlxlogscore=806
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109030077
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Perhaps update the subject line like, "Define and use an ENGINE field
in libimaevm_params".

On Tue, 2021-08-10 at 09:45 -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Extend the global libimaevm_params structure with an ENGINE field 'eng'
> and use it in place of the local ENGINE variable in main().
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

thanks,

Mimi

