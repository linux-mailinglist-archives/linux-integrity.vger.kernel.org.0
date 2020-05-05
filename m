Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4824C1C5B6E
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2020 17:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgEEPdW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 May 2020 11:33:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730347AbgEEPdQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 May 2020 11:33:16 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 045FV0Vs191030;
        Tue, 5 May 2020 11:33:12 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30u9aybp9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 11:33:12 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 045FVenr193308;
        Tue, 5 May 2020 11:33:11 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30u9aybp8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 11:33:10 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 045FUr9J031283;
        Tue, 5 May 2020 15:33:08 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 30s0g5q982-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 15:33:08 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 045FX6Do55967892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 May 2020 15:33:06 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B9EFA405B;
        Tue,  5 May 2020 15:33:06 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D7BFA405C;
        Tue,  5 May 2020 15:33:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.200.227])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 May 2020 15:33:05 +0000 (GMT)
Message-ID: <1588692785.5157.11.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] ima: verify mprotect change is consistent with mmap
 policy
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 05 May 2020 11:33:05 -0400
In-Reply-To: <7812a3a7-f47d-c924-c12e-f417bb6f43dc@linux.microsoft.com>
References: <1588627060-7399-1-git-send-email-zohar@linux.ibm.com>
         <7812a3a7-f47d-c924-c12e-f417bb6f43dc@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-05_08:2020-05-04,2020-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005050121
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-05-04 at 15:51 -0700, Lakshmi Ramasubramanian wrote:
> On 5/4/20 2:17 PM, Mimi Zohar wrote:
> 
> Hi Mimi,
> 
> > +int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
> > +{
> > +	struct ima_template_desc *template;
> > +	struct inode *inode;
> > +	int result = 0;
> > +	int action;
> > +	u32 secid;
> > +	int pcr;
> > +
> > +	if (vma->vm_file && (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
> 
> Just a suggestion:
> Maybe you could do the negative of the above check and return, so that 
> the block within the if statement doesn't have to be indented.

Good suggestion.

> 
> > +		inode = file_inode(vma->vm_file);
> > +
> > +		security_task_getsecid(current, &secid);
> > +		action = ima_get_action(inode, current_cred(), secid, MAY_EXEC,
> > +					MMAP_CHECK, &pcr, &template, 0);
> > +
> > +		if (action & IMA_APPRAISE_SUBMASK)
> > +			result = -EPERM;
> > +
> > +		if ((action & IMA_APPRAISE_SUBMASK) || (action & IMA_MEASURE)) {
> 
> action is checked for IMA_APPRAISE_SUBMASK bits in the previous if 
> statement. Does it need to be checked again in the above if statement?

Agreed, the code should be cleaned up here too.  In either the
measurement or the appraisal case, mprotect modifying the execute mmap
flag should be audited, but only in the appraisal case is the request
denied.

Mimi

> 
> > +			struct file *file = vma->vm_file;
> > +			char *pathbuf = NULL;
> > +			const char *pathname;
> > +			char filename[NAME_MAX];
> > +
> > +			pathname = ima_d_path(&file->f_path, &pathbuf,
> > +					      filename);
> > +			integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
> > +					    pathname, "collect_data",
> > +					    "failed-mprotect", result, 0);
> > +
> > +			if (pathbuf)
> > +				__putname(pathbuf);
> > +		}
> > +	}
> > +	return result;
> > +}
> 
> thanks,
>   -lakshmi
> 

