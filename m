Return-Path: <linux-integrity+bounces-677-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F7282647D
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Jan 2024 15:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D31281F70
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Jan 2024 14:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815AC134B3;
	Sun,  7 Jan 2024 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y0x1HsFv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF69134B6
	for <linux-integrity@vger.kernel.org>; Sun,  7 Jan 2024 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4079C30G020480;
	Sun, 7 Jan 2024 14:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZRfiwG5Yw33z5TVnkwGssgOxx1K3/6gOiJQr5AOTx5g=;
 b=Y0x1HsFvRPTWKNkDlqXVr+ZUkfVKrGosLcJ90jDlVldOH8zHCvaIJgO47zNVybYgeWOi
 N/eaNwpn8LAuyKvqadmW2QN/mQkkCOAx5SoM5nuPAYaEMsvJEgfuILadby178NxPxkQA
 EWSgsjvNWE5VmW74MiNPNGNAJ2dfiuUvXwX/7mv/n9AdrU8jfJ1xHekaLF5o6gqgozTt
 lPXlba4t4L6eDEXatcvHthqmZCHOHIbclaMJrYXbyOz/mqp8JpHuzZJq1eSk9T3Yc/Rs
 B/GfxrgIBb2A5Usi8XVtVVaiqBUXXTN69LSC0hYCi2xoD6PbG1fzjW/x3d8nae3durgh fA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vf5qguuft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jan 2024 14:24:53 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 407B25HT000906;
	Sun, 7 Jan 2024 14:24:52 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkdjtfd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jan 2024 14:24:52 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 407EOp6m58065270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jan 2024 14:24:52 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAF7A58043;
	Sun,  7 Jan 2024 14:24:51 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EF8D5805D;
	Sun,  7 Jan 2024 14:24:51 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.155.63])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jan 2024 14:24:51 +0000 (GMT)
Message-ID: <ddd990a0faeb79260709b973b2b959a89e6c65bc.camel@linux.ibm.com>
Subject: Re: [PATCH v3 7/7] ima: measure kexec load and exec events as
 critical data
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Sun, 07 Jan 2024 09:24:50 -0500
In-Reply-To: <db16303d-44b7-45d2-b844-cf4d7fe89647@linux.microsoft.com>
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
	 <20231216010729.2904751-8-tusharsu@linux.microsoft.com>
	 <0c98853722d57472d451e7838d4b1176665de1c0.camel@linux.ibm.com>
	 <db16303d-44b7-45d2-b844-cf4d7fe89647@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Dq5VjJts3chRTDZ1p1GsYWvkdlOmXqFq
X-Proofpoint-ORIG-GUID: Dq5VjJts3chRTDZ1p1GsYWvkdlOmXqFq
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-07_08,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401070069

On Fri, 2024-01-05 at 12:22 -0800, Tushar Sugandhi wrote:
> >> @@ -194,6 +206,15 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
> >>              return ret;
> >>      }
> >>   
> >> +    buf_size = ima_get_binary_runtime_size();
> >> +    scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
> >> +              "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;",
> >> +              kexec_segment_size, buf_size);
> >> +
> >> +    ima_measure_critical_data("ima_kexec", "kexec_execute",
> >> +                              ima_kexec_event, strlen(ima_kexec_event),
> >> +                              false, NULL, 0);
> >> +
> > 
> > Please consider including the number of measurement records as well.
> Will do. I think that would be valuable information.
> 
> Per my understanding, I will have to use the function
> ima_show_measurements_count() or ima_show_htable_value() to get the
> number of measurement records value[1]. So I will have to expose that
> function from "ima_fs.c" to "ima_kexec.c". Hope that's ok.
> 
> [1] 
> https://elixir.bootlin.com/linux/latest/sourcesecurity/integrity/ima/ima_fs.c 
> 
> 
> static ssize_t ima_show_measurements_count(struct file *filp,
>                                           char __user *buf,
>                                           size_t count, loff_t *ppos)
> {
>          return ima_show_htable_value(buf, count, ppos, &ima_htable.len);

I don't see a need to expose this function.  ima_htable is defined in ima.h. 
You can read the ima_htable.len directly, as ima_show_htable_value does.

-- 
thanks,
 
Mimi
 



