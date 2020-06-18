Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38D01FFACC
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 20:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgFRSKP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 14:10:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48099 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726882AbgFRSKP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 14:10:15 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05II1c7l055630;
        Thu, 18 Jun 2020 14:10:12 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ra0vy1df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 14:10:12 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05II2fna058528;
        Thu, 18 Jun 2020 14:10:11 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ra0vy1c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 14:10:11 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05IIA7wM007860;
        Thu, 18 Jun 2020 18:10:10 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 31qur61fm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 18:10:09 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05IIA6PO61210882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jun 2020 18:10:06 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B6AAAE06A;
        Thu, 18 Jun 2020 18:10:06 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E2B4AE05F;
        Thu, 18 Jun 2020 18:10:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.230.246])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Jun 2020 18:10:05 +0000 (GMT)
Message-ID: <1592503804.4615.47.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] integrity: Add errno field in audit message
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        bauerman@linux.ibm.com, nayna@linux.ibm.com, sgrubb@redhat.com,
        paul@paul-moore.com
Cc:     rgb@redhat.com, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Date:   Thu, 18 Jun 2020 14:10:04 -0400
In-Reply-To: <8b3c99b9-6691-5ae2-a287-a22a2c801c59@linux.microsoft.com>
References: <20200617204436.2226-1-nramas@linux.microsoft.com>
         <20200617204436.2226-2-nramas@linux.microsoft.com>
         <1592502095.4615.42.camel@linux.ibm.com>
         <8b3c99b9-6691-5ae2-a287-a22a2c801c59@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_14:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 bulkscore=0 cotscore=-2147483648 lowpriorityscore=0
 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006180134
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-06-18 at 11:05 -0700, Lakshmi Ramasubramanian wrote:
> On 6/18/20 10:41 AM, Mimi Zohar wrote:
> 
> > 
> > For the reasons that I mentioned previously, unless others are willing
> > to add their Reviewed-by tag not for the audit aspect in particular,
> > but IMA itself, I'm not comfortable making this change all at once.
> > 
> > Previously I suggested making the existing integrity_audit_msg() a
> > wrapper for a new function with errno.  Steve said, "We normally do
> > not like to have fields that swing in and out ...", but said setting
> > errno to 0 is fine.  The original integrity_audit_msg() function would
> > call the new function with errno set to 0.
> 
> If the original integrity_audit_msg() always calls the new function with 
> errno set to 0, there would be audit messages where "res" field is set 
> to "0" (fail) because "result" was non-zero, but errno set to "0" 
> (success). Wouldn't this be confusing?
> 
> In PATCH 1/2 I've made changes to make the "result" parameter to 
> integrity_audit_msg() consistent - i.e., it is always an error code (0 
> for success and a negative value for error). Would that address your 
> concerns?

You're overloading "res" to imply errno.  Define a new parameter
specifically for errno.

Mimi
