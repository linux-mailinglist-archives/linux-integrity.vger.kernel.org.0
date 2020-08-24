Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FFB2509CF
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Aug 2020 22:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgHXUMJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Aug 2020 16:12:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbgHXUMH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Aug 2020 16:12:07 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07OK3GPT109283
        for <linux-integrity@vger.kernel.org>; Mon, 24 Aug 2020 16:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=BQDb9jJOP9C3f05xKzldX/n2cK1uWJUUd8tvVWFl05A=;
 b=Pe32J4hgCFdIn+3cP3aYBH5Ljx4d2Nq23jhrVxe2uTCT6mYZmivMBdhBe9VUZBDZAjlR
 WOUXf7J8M8pbDMAQs/h3rfC31cgSzgi0q1Ke4hQ4hvY754+ENM8wKj3V0uodeuFgKtt5
 h6wy7Y+P5ZlHg6tVDex08J8DYKm7E5AQ70rPoZWBpUj9Fv0HFZm/tFoKR4YaxwFFULBI
 W9d1QsiJ6WwUijBB0hektdOKL3KniuyjqwhQcaaZdPqoNNOimlpB9RacYHG2Crv/HG4H
 LFHeTiNYi6l7h30/VW1G3ZuMXPmE0jOW4Tw3Tw6KaxvYKVLA1h1WogwV/eJ/Quk/g+sv 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 334kvhh08c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 24 Aug 2020 16:12:06 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07OKBSrr144056
        for <linux-integrity@vger.kernel.org>; Mon, 24 Aug 2020 16:12:06 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 334kvhh07r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 16:12:06 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07OK8a3b023227;
        Mon, 24 Aug 2020 20:12:04 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 332uk6apxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 20:12:04 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07OKC1gL19399054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 20:12:01 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE113AE051;
        Mon, 24 Aug 2020 20:12:01 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0E46AE056;
        Mon, 24 Aug 2020 20:12:00 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.122.56])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Aug 2020 20:12:00 +0000 (GMT)
Message-ID: <9c5544c2d82651c5b44751b4f3fa0231bc19135a.camel@linux.ibm.com>
Subject: Re: [PATCH 2/4] integrity: invalid kernel parameters feedback
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Bruno Meneguele <bmeneg@redhat.com>,
        linux-integrity@vger.kernel.org
Date:   Mon, 24 Aug 2020 16:11:59 -0400
In-Reply-To: <20200817215233.95319-3-bmeneg@redhat.com>
References: <20200817215233.95319-1-bmeneg@redhat.com>
         <20200817215233.95319-3-bmeneg@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240155
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-08-17 at 18:52 -0300, Bruno Meneguele wrote:
> Prompt a message to kmsg in case the user entered any invalid option to some
> of the ima_{policy,appraise,hash} and evm kernel parameters. It's already
> done for ima_template.

I think what you are trying to say is don't silently ignore unknown or
invalid  ima_{policy,appraise,hash} and evm kernel boot command line
options.

Mimi

