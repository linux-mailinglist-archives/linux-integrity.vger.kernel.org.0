Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AE8232A58
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jul 2020 05:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgG3DYG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Jul 2020 23:24:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17288 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726519AbgG3DYF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Jul 2020 23:24:05 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06U31lKw140487;
        Wed, 29 Jul 2020 23:24:04 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32jw7223qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jul 2020 23:24:04 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06U3G7VW008933;
        Thu, 30 Jul 2020 03:24:02 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 32gcpx5rem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jul 2020 03:24:01 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06U3MYnN66453924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jul 2020 03:22:34 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEED1AE04D;
        Thu, 30 Jul 2020 03:23:59 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13C3DAE045;
        Thu, 30 Jul 2020 03:23:59 +0000 (GMT)
Received: from sig-9-65-244-68.ibm.com (unknown [9.65.244.68])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Jul 2020 03:23:58 +0000 (GMT)
Message-ID: <59f23e8953c0735695e5679fc7b7021252837874.camel@linux.ibm.com>
Subject: Re: Measure data again even when it has not changed
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>
Date:   Wed, 29 Jul 2020 23:23:58 -0400
In-Reply-To: <8bcf778d-8fa8-9985-43d7-c2b80d8d8445@linux.microsoft.com>
References: <8bcf778d-8fa8-9985-43d7-c2b80d8d8445@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-30_01:2020-07-29,2020-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 impostorscore=0 adultscore=0 suspectscore=3 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300017
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-07-29 at 10:17 -0700, Lakshmi Ramasubramanian wrote:
> Hi Mimi,
> 
> I have a query related to measuring data (by IMA subsystem) when that 
> data has been already been measured.
> 
> Consider the following sequence of events:
> 
> => At time T0 IMA hook is called by another subsystem to measure data 
> "foo". IMA measures it.
> 
> => At time T1 data is "bar". IMA measures it.
> 
> => At time T2 data is "foo" again. But IMA doesn't measure it since it 
> is already in the measured list.
> 
> But for the subsystem making the call to IMA, the state has changed and 
> "foo" has to be measured again.
> 
> One way to address the above is to use unique "event name" in each call 
> so that IMA measures the given data every time.
> 
> Is there a better way to address the above?

Most likely the file is being re-measured, but the new value already exists in
the hash table so it isn't being added to the IMA measurement list or extending
the TPM.  When IMA was upstreamed, there was concern about TPM performance and
the number of measurements being extended.  We've improved TPM performance quite
a bit.  If you're not concerned about TPM performance, I would define a new
template data field based on i_version.

Mimi




