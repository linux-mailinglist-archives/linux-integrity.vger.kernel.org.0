Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0C226E00C
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Sep 2020 17:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgIQPvM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Sep 2020 11:51:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728170AbgIQPu6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Sep 2020 11:50:58 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08HEWauU028459;
        Thu, 17 Sep 2020 10:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=To+J8z850vSpFC7aX9KEA79eg23+s5l7OHxQ2TG95IY=;
 b=JvJoOcGiJCgx4z1TDcVXU70DTvSgu/e4P7db+IgwBgChKfkpHdryCOXH1lp2Fyl1zvZe
 oKScjZPd3Esue4gbWqWtc/cOdGcoj4ftSJ4j7WXxakBkh4HzmA6kytVDgjksQggpqiB0
 ekrFloH7ItrLoJzrFCklHbXZ01vllZOt+rrdeUkhV3n65xsY30QrET3JGzajgJ/L9/Z6
 wBVDynW0/20ws9qo6kVa7aO/rstphBzWhNWGkpu8/y0b4uEnt0sZS3Yw2zrBED67+OBp
 gBMNl2WCvQT44aoesiYS6bpXa4zmkujyfAMUjVi8AYkjZ2oxvNHrHf1psZwjEMkX2m/F TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33m9msr133-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 10:33:14 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08HEXDns029650;
        Thu, 17 Sep 2020 10:33:13 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33m9msr12g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 10:33:13 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08HERKbZ023105;
        Thu, 17 Sep 2020 14:33:11 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 33k9gea28v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 14:33:11 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08HEX8So30802224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Sep 2020 14:33:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA1E3AE056;
        Thu, 17 Sep 2020 14:33:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86824AE059;
        Thu, 17 Sep 2020 14:33:07 +0000 (GMT)
Received: from sig-9-65-208-105.ibm.com (unknown [9.65.208.105])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Sep 2020 14:33:07 +0000 (GMT)
Message-ID: <38c4f09a9aba7dfd483d7a80f8656e7a1868fad2.camel@linux.ibm.com>
Subject: Re: [PATCH v2 00/12] IMA/EVM fixes
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Thu, 17 Sep 2020 10:33:06 -0400
In-Reply-To: <681455532936011e3dc5e0050fddc2c3a3a7fc3c.camel@linux.ibm.com>
References: <20200904092339.19598-1-roberto.sassu@huawei.com>
         <681455532936011e3dc5e0050fddc2c3a3a7fc3c.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_09:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=3 clxscore=1015
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170113
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

On Wed, 2020-09-16 at 12:14 -0400, Mimi Zohar wrote:
> On Fri, 2020-09-04 at 11:23 +0200, Roberto Sassu wrote:
> > This patch set includes various fixes for IMA and EVM.
> > 
> > Patches 1-3 are trivial fixes. 
> 
> I've queued these patches in the next-integrity-testing branch for now.
> When reposting this patch set please replace the cover letter subject
> line with a more appropriate one.
> 
> > The remaining improve support and usability
> > of EVM portable signatures. In particular patch 4 allows EVM to be used
> > without an HMAC key.
> 
> EVM already supports using EVM portable and immutable sigatures without
> an HMAC key.   
> 
> I was able to apply this patch set, but patch 10/12 does not apply
> cleanly due to the "fallthrough" line.  Please hold off on reposting,
> until I've finished reviewing the entire patch set.

Done.  Other than the one issue of clearing the EVM_RESET_STATUS in
evm_verifyxattr(), the remaining changes are straight forward.

thanks,

Mimi

