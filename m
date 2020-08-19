Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7783B249FD5
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Aug 2020 15:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgHSN1x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 09:27:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17712 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727926AbgHSN1x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 09:27:53 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07JD659W148441;
        Wed, 19 Aug 2020 09:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=JLh3E1sQD2+HGJKUWV+uPP+J+R9Me39zaFIx27TIfYc=;
 b=IEDz1SVBE8qwoGtExfQQQhSAEa8tTRk8QdG/XwJlqahfTOV206/zETqXALAHdKvI7SFA
 UXlGJzPr5+qSMSAhXGUabGZFVkdyw328Ol+wdpOJIpn22F/nH872syEUbDgkn6+YQw/r
 roQfZnQMbJIYsSfyY2at03g/2lK8Ho7dhIpnQZfeWXbdh/BvHlyguV9EiC+Wa9ZqTLex
 KdPK+IeQkYBaGXnnv7wRygKoqKWuEBHfSxn+bsuF1JUCyZx9CJqj7yyUkB8uDKN2D9qk
 JfGknc21YHt3cNHCGf2pGBkwhcL5CBlIHOjYiQPePOEfg4gNtRUqmCudLdpz8oyqRfsV DQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3304sxdfdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 09:27:40 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07JDMEM6013604;
        Wed, 19 Aug 2020 13:27:38 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 330tbvrm6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 13:27:38 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07JDRaEp56426972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Aug 2020 13:27:36 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 061DF11C04C;
        Wed, 19 Aug 2020 13:27:36 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD34611C054;
        Wed, 19 Aug 2020 13:27:34 +0000 (GMT)
Received: from sig-9-65-250-194.ibm.com (unknown [9.65.250.194])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Aug 2020 13:27:34 +0000 (GMT)
Message-ID: <59f983156fed466d568c324de72ef733c1a15d76.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 19 Aug 2020 09:27:33 -0400
In-Reply-To: <20200819120238.GD1152540@nvidia.com>
References: <20200817213506.4474-1-James.Bottomley@HansenPartnership.com>
         <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
         <20200818161207.GC137138@linux.intel.com>
         <20200818161955.GD137138@linux.intel.com>
         <20200818162630.GE137138@linux.intel.com>
         <20200818164602.GZ1152540@nvidia.com>
         <39eb6b408e7f060ab241954102d06f97d1f99611.camel@linux.ibm.com>
         <20200818183603.GC1152540@nvidia.com>
         <14eaf21a808e333ca414c954d8f3a2f7b6dbf2ca.camel@linux.ibm.com>
         <20200819120238.GD1152540@nvidia.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_04:2020-08-19,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=992 lowpriorityscore=0
 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=3 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008190115
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-08-19 at 09:02 -0300, Jason Gunthorpe wrote:
> On Tue, Aug 18, 2020 at 02:55:50PM -0400, Mimi Zohar wrote:
> 
> > The problem is that there isn't just one single userspace library or
> > application for reading PCRs.  So now not only is there the kernel
> > "boot_aggregate" regression testing, but regression testing of the tool
> > itself to support multiple methods of reading the PCRs.
> 
> I was thinking just open code 
>   open("/dev/tpm")
>   write(read_pcrs_cmd)
>   read(read_pcrs_cmd)
>  
> It isn't particularly hard to retrive the PCRs, don't really need to
> depend on a library.

Ok, do you want to contribute it to ima-evm-utils?  While you're at it,
do you also have code to parse the TPM 2.0 event log that you could
contribute?

Seriously, we shouldn't be (re-)writing code to do this.

Mimi

