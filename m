Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0E71723B8
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2020 17:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbgB0Ql7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Feb 2020 11:41:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730235AbgB0Ql7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Feb 2020 11:41:59 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RGd10M050806;
        Thu, 27 Feb 2020 11:40:56 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ye7120n9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 11:40:55 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01RGebP3030539;
        Thu, 27 Feb 2020 16:40:53 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 2ydcmm2dux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 16:40:53 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01RGepGs50069896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 16:40:51 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70C88BE053;
        Thu, 27 Feb 2020 16:40:51 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29C17BE051;
        Thu, 27 Feb 2020 16:40:51 +0000 (GMT)
Received: from t440p.yottatech.com (unknown [9.85.132.1])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 27 Feb 2020 16:40:50 +0000 (GMT)
Received: (from gcwilson@localhost)
        by t440p.yottatech.com (8.15.2/8.15.2/Submit) id 01RGekDr003315;
        Thu, 27 Feb 2020 10:40:46 -0600
X-Authentication-Warning: t440p.yottatech.com: gcwilson set sender to gcwilson@linux.ibm.com using -f
Date:   Thu, 27 Feb 2020 10:40:46 -0600
From:   George Wilson <gcwilson@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        Linh Pham <phaml@us.ibm.com>
Subject: Re: [PATCH] tpm: ibmvtpm: retry on H_CLOSED in tpm_ibmvtpm_send()
Message-ID: <20200227164046.GA1936@us.ibm.com>
References: <20200227155003.592321-1-gcwilson@linux.ibm.com>
 <20200227162339.GF5140@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200227162339.GF5140@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_05:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 mlxlogscore=797 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270125
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 27, 2020 at 06:23:39PM +0200, Jarkko Sakkinen wrote:
> On Thu, Feb 27, 2020 at 10:50:03AM -0500, George Wilson wrote:
> > tpm_ibmvtpm_send() can fail during LPM resume with an H_CLOSED return
> > from ibmvtpm_send_crq().  The PAPR says, 'The “partner partition
> > suspended” transport event disables the associated CRQ such that any
> > H_SEND_CRQ hcall() to the associated CRQ returns H_Closed until the CRQ
> > has been explicitly enabled using the H_ENABLE_CRQ hcall.' This patch
> > adds a check in tpm_ibmvtpm_send() for an H_CLOSED return from
> > ibmvtpm_send_crq() and in that case calls tpm_ibmvtpm_resume() and
> > retries the ibmvtpm_send_crq() once.
> > 
> > Reported-by: Linh Pham <phaml@us.ibm.com>
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > Signed-off-by: George Wilson <gcwilson@linux.ibm.com>
> 
> What is LPM anyway?

It's PowerVM Live Partition Mobility.

> 
> /Jarkko

-- 
George Wilson
IBM Linux Technology Center
Security Development
