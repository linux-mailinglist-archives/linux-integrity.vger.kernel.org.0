Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E67D39A666
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jun 2021 18:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhFCQ5X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Jun 2021 12:57:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60012 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229692AbhFCQ5W (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Jun 2021 12:57:22 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 153Gcvcp133669;
        Thu, 3 Jun 2021 12:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=fRxP1HniD0QO87d40T/P9s8KMfs49M/EB9hfLfQ8haA=;
 b=EMROv9aNiJfT0mNgloGP/b5R/9DioP8UnHwxDYNx4WnP9uLsy7vlViIZdGRdbWbTR/2W
 I38qumEbVs3yuHXDr8+87g+OiHtDpgPgARPrhNIymaAkyHQSjLWCME1OJ8YQvbV5aFIJ
 MmPaCjid1EEqj8tPiMPFX6BXZF5F2GYjdAHtepQxD6eunmucYWntTPHi5ZmU91PIt0wD
 5xidlWqnYUdaxaCCesNtgF6R19EfCOtUCELjXnFF7DvZYwVeREqVYtjpIEUXw8pBmO9q
 ECYOX/441/7u1OSHlP8VwmT1XOLOKrHkGK9qYrig57u9i1QuLmWji8yKTwgK+hBgs8Gc +w== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38y19jurg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Jun 2021 12:55:22 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 153GmfR4026832;
        Thu, 3 Jun 2021 16:55:20 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 38ud88b3ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Jun 2021 16:55:20 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 153GtIqP32113078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Jun 2021 16:55:18 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C6A442041;
        Thu,  3 Jun 2021 16:55:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6D6342042;
        Thu,  3 Jun 2021 16:55:16 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.13.122])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Jun 2021 16:55:16 +0000 (GMT)
Message-ID: <f29c8302fbb83fa05cf4cddb48144e32b14a6851.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 2/2] evm: output EVM digest calculation info needed
 for debugging
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     nramas <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Russell Coker <russell@coker.com.au>
Date:   Thu, 03 Jun 2021 12:55:14 -0400
In-Reply-To: <a994cedd0b2a07faf8d1949448ec9c14b3dba34c.camel@linux.microsoft.com>
References: <20210603151819.242247-1-zohar@linux.ibm.com>
         <20210603151819.242247-3-zohar@linux.ibm.com>
         <a994cedd0b2a07faf8d1949448ec9c14b3dba34c.camel@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kkNTsO2eqGgkeZO0hTfX9jD0g-zTxk7i
X-Proofpoint-ORIG-GUID: kkNTsO2eqGgkeZO0hTfX9jD0g-zTxk7i
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-03_10:2021-06-03,2021-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030111
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

On Thu, 2021-06-03 at 09:34 -0700, nramas wrote:
> > +void evm_bin2hex_print(const char *prefix, const void *src, size_t
> > count);
> >  
> 
> For evm_bin2hex_print() can we could do the following in evm.h?
> 
> #ifdef DEBUG
> void evm_bin2hex_print(const char *prefix, const void *src, size_t
> count);
> #else
> void evm_bin2hex_print(const char *prefix, const void *src, size_t
> count) {}
> #endif /* DEBUG */

Yes, if we decide that it needs to be based on DEBUG, this would be the
proper way of doing it.  However, since there's nothing really private
here, it's just displaying the security xattrs and other file metadata,
should enabling/disabling the debugging be runtime configurable?   Kind
of like how print_hex_dump() relies on loglevel.  Or should it be more
granular?

thanks,

Mimi

